Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042F37F8A8
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711583; cv=none; b=On/7SYTs9/B+p9Mcct40E9Aer6MURNUcMgnNEITlgDqYDL60LrkV0qUsH89tN2RxIB4AmQpjIXmqtPK7ER/VInUmuaJoyS1XMW+PFZ2oUkuHiFvoKe/uJWjlt5iVnKqOHh7mIvaRSrTkJm/iPbjOpHL92c5lFL5sky1y71bUg5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711583; c=relaxed/simple;
	bh=/i4iQVVYgZcyZkahqB/Yq4izkN3VKOXSgDTz3AsYNTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBza63+MlIHXobNHXBB3FjHB0YpHGYBHPDauGO3M1rmLn0r41FIHMf92jq9gTcPLzeayIOXPP7GxG0ATH8Lxxnq0BKryl2w/gj7l/m67zvgnSsCmtNgFadDsH9BacD4xl8OhoRE13lB87q1XwuRSCI0bScnu2WZo/MFwpYPkDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7WQ2Zns; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7WQ2Zns"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso7258477eec.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711580; x=1779316380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uSoqkJU8a2VQZhervRKHGXNqeNUvIdC6OMh7SCfL6fk=;
        b=D7WQ2ZnsIVpUZ5yfP4dzrtkImYWkjU7xeCJZva4XgAt4pQmhJzWKHWXDDTK0F78mgl
         w3limhtQyrpjuOHpNLmj0wWhI67/0LNVn6oTlmKu3ArZ5yrnAp3112wR2wPpt//p0KxE
         bjaCRFicA8WoD0YPXQgN5dkNzf9JDYGxqd7ToxR5iVp6uFC3bFiVEK4Gor1oFYVnxLwo
         fBcR0pcyL2EdxTcR3OmILng3wJWzURBsJkah6POuuKjbiJZpdZ0ZoEI66Kyrem2MGmC1
         jW9B9uIpd3O9Wyd8d4tHH/J2Z0cM318cPhJo/j7v7teXtVHg9lNccgZq0D/3Unxf9Ihk
         l7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711580; x=1779316380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSoqkJU8a2VQZhervRKHGXNqeNUvIdC6OMh7SCfL6fk=;
        b=cvbq7mtZ2E02SDyR7vmnGp8TpGAuWMkBR5cPw91G6erkHIhkyG53q2xvo5vJyta3GP
         d3vmSNJVvQSEIzQNKX4ceYMHXwt5B4Um6JDOup1Qd9qPD1pG1t5QC8QFeSF90+GY+26k
         C1FI1YA17UEG0lIZ7VW9pl4r0e8sTfuKP/te/RxpPftG9gNHAZ6vKTxu0PdhNGhMVUk/
         vf46xlwRubItzZ2CFsFAXEQ5XVVge5YnoJkAFl1FO45JU+o4WgT8L0e2pINhgGM4Uf/Y
         TvJUZzgmvPhATOfHKijsjtV388oNrjhgTsFc4f1tNDe0rGUJuG+NTetpUIpRfWGNh8Vs
         DJ4A==
X-Gm-Message-State: AOJu0Yy1eBahzZsfONa4wArTZ+ym0bep+AuagEre+aal28VKGsNaAhkQ
	KTERFTKaaX4/pPqB6jEyLIT3gJ0S87iT7Ew8cKotVQBlo3Pv5JQB92jK
X-Gm-Gg: Acq92OEb27DKeRgUPPk66i5xK7Vf0qGnYjT48aRh+oBxRx3/Z5B9ikLjKvaQgkg2uvP
	C4DGRJgAn/uoyridM4Ft7R/hn4pklk51C1OVR2CQab9KsmN/yiIfa/s2YJSXLEF3/kDMzP2E6jk
	Y7jpUINqNWqKr+QyTPLnxzWEXareSgrpXRkKngKE3IPjgrPmHlzxEfgy3fn04KuJ7sJitX7nMzn
	IIn64AmoAyiVQRdYQXPX7lzRJJzulpfqE3YRDaQf/64eChghGQUKDC4PhTzNSYkak9QUNqoFuSs
	cHYVCwIKyI0hYdHj1Og7hJ6clOQQI/XNy3E8Dj4Qozq849krpSlh1sOh6U4quyJpaVe2IJM3h18
	xRmv6sJT71+nXmWLNHQdfxiyWnkzYOWV5LImGZP0nuLm0KHe7FZkaLArRei8hDT2Olj4wKSkgP3
	Pg2AyigRkEOyx/P0Kx8vaxdtkeqLZwhWs+pC5Tt50CaDmsD6Pkb7MmYqZwWa5P5FSZ1XBt5+oxy
	obentc=
X-Received: by 2002:a05:7301:1011:b0:2be:833c:149d with SMTP id 5a478bee46e88-30119f71457mr2928472eec.28.1778711580223;
        Wed, 13 May 2026 15:33:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm761840eec.13.2026.05.13.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:32:59 -0700 (PDT)
Message-ID: <ca14a6fd8a1f3ce1e64c70b6d9ea2baf8df913ae.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 3/8] bpf: Introduce the bpf_list_del
 kfunc.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao cheng <kaitao.cheng@linux.dev>, ast@kernel.org, corbet@lwn.net, 
	martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org
Date: Wed, 13 May 2026 15:32:57 -0700
In-Reply-To: <20260512055919.95716-4-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
	 <20260512055919.95716-4-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 13:59 +0800, Kaitao cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> Allow users to remove any node from a linked list.
>=20
> We have added an additional parameter bpf_list_head *head to
> bpf_list_del, as the verifier requires the head parameter to
> check whether the lock is being held.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -11456,7 +11459,8 @@ static bool check_kfunc_is_graph_node_api(struct =
bpf_verifier_env *env,
> =20
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
> -		ret =3D is_bpf_list_push_kfunc(kfunc_btf_id);
> +		ret =3D is_bpf_list_push_kfunc(kfunc_btf_id) ||
> +		      kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_del];

Nit: to keep everything in the same style, maybe add a is_bpf_list_del_kfun=
c() helper?

>  		break;
>  	case BPF_RB_NODE:
>  		ret =3D (is_bpf_rbtree_add_kfunc(kfunc_btf_id) ||
