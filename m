Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F18472794
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571433; cv=none; b=FlMg1vvg/JHgG46TVq+96m5TPnWDwshyoxip37Fq1gs2YLymrx+K0nXDFh3tNrPIkuCouc0eIqZIpaWA6IjMxq2V65iTKblhVaN15FGFhDcxFkwLP0w5LahUFpX7yP37bzfkZ4LPAcwiHQvN9qYoHBWkPTaZsmCuxs7PQRNw1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571433; c=relaxed/simple;
	bh=kEdW7EIrFjhtlqsPOdgL64/jkA4ADvKNvNxeaOjLL1I=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=iKDtYpML+7GBYUdDQBzfnWqPeL/kl6UWXIEpWcvxPqBqKOxHcGSpKxN+s/SyZwb+1FKiLQPscbrbLeLgUxIASFL0aLgYKooWDjdWwfRilK+Nn/DJtsNPful36B89fmLUsU+MNFFbKXaXurNCw6qbLUsZkLhTds1qhKu51K3eXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nY4RuW/O; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nY4RuW/O"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777571429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nw/7KpLkvKo4TFF8/HeokXiwpBf9w53SwvYgIfr+UD4=;
	b=nY4RuW/OKLGNb4QSU9YL8m53BIZgS9aLj42bOOsWrTWp7FDttAC4l3TsMTdS0wguWMUYeq
	Gd6vrCmU1p8G7Vj8J9vX0bm0bNanTBeSr6e9Q85uZl6SErNDOiLRCmxv7ugyJYfrEWMDEg
	ufWY/k8cIaU/xQyEUtBBpYf9Pw6l4Xk=
Date: Thu, 30 Apr 2026 17:50:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <f3778bc7e9dd3b2f213a847cf9229f82dd70507c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net 6/7] net: tls: fix use-after-free in
 tls_sw_sendmsg_locked after bpf verdict
To: "Jakub Kicinski" <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net,
 linux-kselftest@vger.kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 "Alessandro G" <ale.grpp@gmail.com>, ast@kernel.org
In-Reply-To: <20260429222944.2139041-7-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
 <20260429222944.2139041-7-kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT

April 29, 2026 at 3:29 PM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@=
kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:


>=20
>=20After bpf_exec_tx_verdict() returns in the zerocopy path, the local
> msg_pl/msg_en pointers may be stale. If a BPF program set apply_bytes
> such that tls_push_record() splits the open record via
> tls_split_open_record(), ctx->open_rec is replaced with the split
> remainder while the original record is pushed to the tx_list and may
> be freed by tls_tx_records(). The caller's cached msg_pl/msg_en still
> reference the old (now-freed) record.
>=20
>=20This is triggered when bpf_exec_tx_verdict() returns -ENOSPC (BPF set
> cork_bytes > remaining data) after an internal record split: the code
> dereferences msg_pl->cork_bytes on the freed record, causing a UAF.
>=20
>=20Reported-by: Alessandro G <ale.grpp@gmail.com>
> Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: john.fastabend@gmail.com
> CC: sd@queasysnail.net
> CC: jiayuan.chen@linux.dev
> CC: ast@kernel.org
> CC: bpf@vger.kernel.org
> ---
>  net/tls/tls_sw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
>=20diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 600e13effaab..d086b43fc675 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1157,6 +1157,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk=
, struct msghdr *msg,
>  else if (ret =3D=3D -ENOMEM)
>  goto wait_for_memory;
>  else if (ctx->open_rec && ret =3D=3D -ENOSPC) {
> + /* bpf_exec_tx_verdict() may have
> + * called tls_split_open_record(),
> + * freeing the old record. Re-fetch.
> + */
> + rec =3D ctx->open_rec;
> + msg_pl =3D &rec->msg_plaintext;
> + msg_en =3D &rec->msg_encrypted;
>  if (msg_pl->cork_bytes) {
>  ret =3D 0;
>  goto send_end;
> --=20
>=202.54.0
>=20

Reviewed-by:=20Jiayuan Chen <jiayuan.chen@linux.dev mailto:jiayuan.chen@l=
inux.dev=20>
