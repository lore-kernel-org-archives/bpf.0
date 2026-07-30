Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9D3B19D6
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393053; cv=none; b=PRZ1UG9M+MLcOJeo245WjFr2Qkn1TvmBkUbMM3ExXGsyrILmrkBBCoJk6kRMg0n0ZFFmxgKlPOMbM2hZV2Qq9nM1xi945e2470d7jsLhFR4lTVUYIjnx360aBctHojmBPB1w0Y7w5NseYTFKVXAw1fPW9Xe7wR6JjQGV++QmQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393053; c=relaxed/simple;
	bh=yMQpoF8DD4VnQlsoAsOC+G3DWvFvHyp5SxTVysKpeDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RhNa1Jzu+/MAMVOESa87bpMZzEaggQXmGnRSrn8CdANGAOUKA2eKn2gHFJBqcx3Mn6Icu+6BOA5T48XMmg6Ohz23MkJuxRLWZqa2pt7wKcHjyPS5YDvmknh1Ik7tdNCjv0HxutNOBBdb6TiY0sKZBcTrIthCdxHwJL5X6fLSl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MASYlQ67; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MASYlQ67"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cedda2ce6fso15290485ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785393049; x=1785997849; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iPeTC0M7DIZ2pnkA7MkWgScCORZlZeaBMPqwxcNhcbk=;
        b=MASYlQ677jQz136qQyPLxJtmnVeGJHb0KQVGD9r3ZqW6iL/CQI2kHpZbHaWLIQ9Snc
         D/C8zd+eBFs0mMBVNraaeMXeKwoXDkOoDwkFeNE9WG3g876t5o0XuWAMbq6l/jbno7qK
         Fk+CXzDrYiQoxHIGPlOuz32mnQ9JOFxnjv8cw2OYMe0WhJd8Yhe/EdtqnFANDyGWZgoK
         kqwGWjBsoyKfyLAxha3PbILlQKG3dSQiFWswv+jCd/HZaROsJ6xJ9k9ksbiUesNIIMYl
         g+18Imbx3bAoN6g/1d5tdDjug8JSwteW+J/gSwPFGWmkadRH1sRTsyeIutmZXXZbgyI0
         On/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393049; x=1785997849;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPeTC0M7DIZ2pnkA7MkWgScCORZlZeaBMPqwxcNhcbk=;
        b=I57/NSwarL8OKyHMaOeQhky4iTdDZd7SluSMwc9T+H0hUEE6YoBD4D8DHa5nUSFqds
         ujvqihorQSrOjArMwvm82djZK1Ast2OKiyPEjH9u6vW/Hg7J2J2yOTbKM/ezwRuZ474M
         BYtOPnYYvKjlZSozUAhWcwO5fmHA/GRx8eponga88OvzpGokiO9TsTzumWerjdb6YuNJ
         8/EUc64U5PzeOAzOi02MP1A944rkgqTYiLUYXgjJypnG0tvenAn2G1xDxR0V/+QkfzdL
         N2BU/kv2ghYS2rn0npu6vEiEW7RHZKxoG6rGGNJRjd4XRdM5bYl7heIITPixHiIF23l/
         utSg==
X-Forwarded-Encrypted: i=1; AHgh+RrcrMGfpPx0TC7g9vKy+QifHyIe74Jnc2KWHMssr99A9Dzk6hLUpnImmuip85Wy/bGNFv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuhwZUcEeKseTz5cMhzNeLLw1Y9CJu/veIZ0tpSJLkzRdF9fv
	L5Yq7A/RbUqNBoj4muWwCd6yNnLsOdbRN0A4x4PMHRUjVlIxLLsk0AhiRg4l24hljkU=
X-Gm-Gg: AR+sD11UkzhvKtxdnmADbJKgf9hBsWvJvumI31JemsJiYFQx803DS6lz68vJnQVCCZY
	mEGS9LOgB5kWD20WQt6/7AB7CaLhjerviUiqM+Mlu1D2uBPitI5OUNUV7+qvpsbk82fkHXO7I8U
	QRtEQlV0aOUf0fVWbWJp8g44k3CsVjPB918w0hbihY8YTUfe8BA8g/rSJ3RZtqbytA2XBwcIcKM
	C2H/yN7bNNcWdGHopC5hjVTaGAx/tgaaWDgQgYnBq8mQq5opfqkhFvAlscFrL4AzVeTSzXfayHC
	HvfKOAuDkbqmM25qqEZnJuwUDf2XxwZQ+FeJsWP5YLxbvm1DV/99vYFtswy6lzMF04mKjsJkoyb
	/1JEZjg45GzhwASCPKnsogRXrD3XEL0PVS8NF2VCg4P2hryUeVv+Q2EYt00eQD/SXxOMpKpiaru
	F0Iv2E81EFIgF0OqgSv1LdH1QhMflEh7iyM2tu0bgyC4VhVBqzgvoU2lQRfQIyy4MwuBQ9Ynh1v
	85u+G8KuFxbvudZeA==
X-Received: by 2002:a17:903:94d:b0:2ca:ed41:d337 with SMTP id d9443c01a7336-2d035d2d515mr14197995ad.43.1785393049372;
        Wed, 29 Jul 2026 23:30:49 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15199sm21124435ad.17.2026.07.29.23.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 23:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 02:30:47 -0400
Message-Id: <DKBP0J41TSLU.1V96E2XEEIOOA@etsalapatis.com>
Subject: =?utf-8?q?Re:_[PATCH_bpf-next_v4]_bpf:_log_error_code_on_trampoline_unlin?= =?utf-8?q?k_failure=C2=A0?=
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <xu.xin16@zte.com.cn>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn>
In-Reply-To: <20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn>

On Wed Jul 29, 2026 at 2:11 AM EDT, xu.xin16 wrote:
> From: Xu Xin <xu.xin16@zte.com.cn>
>
> Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> code from bpf_trampoline_unlink_prog(). This aids debugging of race
> conditions during link teardown, while keeping the warning rate limited
> to avoid log flooding.
>
> This will be very helpful for speeding up trouble-shooting of some crash
> UAF due to bpf_trampoline_unlink_prog failures.
>
> No change to unlink behavior.
>
> Signed-off-by: Xu Xin <xu.xin16@zte.com.cn>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The Sashiko concern seems valid, please let me know if you are
planning on looking into it otherwise I can take a look.

> ---
> Change log:
> - Small fixes according to the v3 disccusion:
>   https://lore.kernel.org/all/82926caa-e16a-457a-8d75-61dfc8dac102@linux.=
dev/
>
>  kernel/bpf/syscall.c    |  8 +++++---
>  kernel/bpf/trampoline.c | 12 ++++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..52c57f8beb37 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3626,10 +3626,12 @@ static void bpf_tracing_link_release(struct bpf_l=
ink *link)
>  {
>  	struct bpf_tracing_link *tr_link =3D
>  		container_of(link, struct bpf_tracing_link, link.link);
> +	int err;
>
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
> -						tr_link->trampoline,
> -						tr_link->tgt_prog));
> +	err =3D bpf_trampoline_unlink_prog(&tr_link->link.node,
> +					tr_link->trampoline,
> +					tr_link->tgt_prog);
> +	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
>
>  	bpf_trampoline_put(tr_link->trampoline);
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..49dceea3d51e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -997,12 +997,15 @@ static void bpf_shim_tramp_link_release(struct bpf_=
link *link)
>  {
>  	struct bpf_shim_tramp_link *shim_link =3D
>  		container_of(link, struct bpf_shim_tramp_link, link.link);
> +	int err;
>
>  	/* paired with 'shim_link->trampoline =3D tr' in bpf_trampoline_link_cg=
roup_shim */
>  	if (!shim_link->trampoline)
>  		return;
>
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node, shim_lin=
k->trampoline, NULL));
> +	err =3D bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->tr=
ampoline, NULL);
> +	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> +
>  	bpf_trampoline_put(shim_link->trampoline);
>  }
>
> @@ -1712,15 +1715,16 @@ int bpf_trampoline_multi_detach(struct bpf_prog *=
prog, struct bpf_tracing_multi_
>  {
>  	struct bpf_tracing_multi_data *data =3D &link->data;
>  	struct bpf_tracing_multi_node *mnode;
> -	int i;
> +	int i, err;
>
>  	trampoline_lock_all();
>
>  	for_each_mnode(mnode, link) {
>  		data->entry =3D &mnode->entry;
>  		bpf_trampoline_multi_attach_init(mnode->trampoline);
> -		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampol=
ine,
> -					NULL, &trampoline_multi_ops, data));
> +		err =3D __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline, =
NULL,
> +					&trampoline_multi_ops, data);
> +		WARN_ONCE(err, "__bpf_trampoline_unlink_prog returns error: %d\n", err=
);
>  	}
>
>  	if (ftrace_hash_count(data->unreg))

