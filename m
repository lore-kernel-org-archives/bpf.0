Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D13515C9
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784869665; cv=none; b=k/F1rpoeMGqHSv8QjcCf5X57fYZUWZlAYiBL3PzH/IrML6FoJwL/a/P45Wzf6qUWQw7fgvMXy19MFWfBzFTP+l52hOy8d1mZnDDyzkJ6FiSX3Yx19kb7iC/+0fGc3eEWWwu3FcQqObSAK8NmeyO/13XCzOhOc5m/epbPFEOfnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784869665; c=relaxed/simple;
	bh=AoXftTuUYB3G91VVyCKghvlnD01941ldzKFRurvlS10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mn99gz9bPZp8Ta40ByFKWm3UarPYDkyd7vKOlFLZnBRiWOG7sV3P+BFmcbPY9a9hoqi7KmHnEgz5CBdsrtD8Fe5CAO3fXwxw9HFlcpfNO98QdG918ITj2pv533Y5b4eRz803RVopux+Ac0gR9xAI+UprErihC9Ooov1jhIm/8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjwcTSY6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjwcTSY6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso513275ad.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784869663; x=1785474463; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AoXftTuUYB3G91VVyCKghvlnD01941ldzKFRurvlS10=;
        b=AjwcTSY6SJvigubVorwQIIPZEG/n5Z/fB6hDeCXW5RNLVR+k7M0XwBo3OXSTqU3PzL
         hg7L/DQULMuxY7drF3Rragdj/yaA2JNLVVzDjMwqJS3OYGq6Bi+o30NzsbDemvh+pMQY
         2QQPNgGVlyVzv1GIK8ToiVApioqIiN+Vo/NeO4GzuiUlWydz8l+1Am8y902ZbD817vki
         y9D9qxER4MJ3SZ2fQ330VLOyixt6NN4rO/06WdEDPs+PuENBui8S0+RsRkhdapQrW2QM
         zACkxH+JMgYFYXvsp40I3MAbN137LzbNtifXSOt7YsvvnzUBycNb8ZCqQVncPpC5GIy9
         Q4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784869663; x=1785474463;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AoXftTuUYB3G91VVyCKghvlnD01941ldzKFRurvlS10=;
        b=OVjYbcdzWnF+ZhyOP027NRhM6lClMc/LwahNXlnADZhY2cJu6D4CrkiUGcw5Y2xP2W
         H8rBVe50QSSjLIBp6ReWCfBzDVIWPoOYuJq7RRQnxuHJhLtTyzA+DL6VNSwFEBPgo6u1
         9MdfUeHTVRNkkqGw5pUC97P9KOgeRArhoiRyE/2UKIP80T6XbFRaSRVu2tfJ7mW1aRF1
         gkfEFfax5maObdPfeUPqtKptsFYtOgckU+RKkTq8OtHaf8HIHc/U10TbRQTvksrsWnub
         CVEWPAgO6QNV2Vw81WCIzO+UQRyqbTS7DyaVw1Psc54CnxeoT/Vx+YxuIaSVCyRdzPnI
         b9Mw==
X-Forwarded-Encrypted: i=1; AHgh+RoCkQtyPexIUqCb+w/xmxJPAqJnXKr5HrpU8OQdaIcmM9eXHjASrPu7+6zsYhytMFYCTUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdMPtkQqPzWI3oqw+KMeJaTFh291AmNtSOcOEFwsmw53Rekwc
	WeQqPz3UrMNymqvbUVZTOTqjtBfSQQqD2v0g1wX1RqJjvcLVHsWd3h1S
X-Gm-Gg: AR+sD11Qvk8hxFtuucLHhe4ewboGSL5Z9pXr1YYwCatjRr7jh3PET3Dyj7zaETleaHM
	U9B6Oqbw1UBlIQOTI5HEVzOXKK80K1YTE6f2eUeYzRkdTZhxsVLrs5urUZVMoHgpk7TBO/jc08W
	6+14mh15NSleKu77rHKpbkUi7imeonlefiq4xzi0pJudFy6t0JA8Iei0H4JzLhkxMHP0+ocGOtt
	363awLCjJ8WrMa7mYaZZswzmzu+1kN4nJ43uNfZbAgULE3fF6fBj55oBdhzbZmcLPvywjy83B7S
	f0vsOTzQwjDwjahv8knqJ76ahHB0iWJ6gB18xbOtIZUVjezrbnwKqLBOfT2ghCQcf5v4DFJIDOx
	Hje/xo8r1T9gwDHqDm1/NOM5wFwir+8LapGvAjIwZkUAncWuqNyAbLEv4VJ5fV47aHuP5ELcx9r
	rL294kqIKdHmQbjdirf2g+FedQ9G1z5w==
X-Received: by 2002:a17:903:b8e:b0:2ca:3e3f:4956 with SMTP id d9443c01a7336-2cfa6f871d0mr72210835ad.44.1784869663343;
        Thu, 23 Jul 2026 22:07:43 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd76cfsm45371835ad.20.2026.07.23.22.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:07:43 -0700 (PDT)
Message-ID: <1e230474ed0de36cc9a9d29fd36eabba628afeb1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Preserve pointer state for
 commuted arithmetic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Yiyang Chen
	 <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend	
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa	
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 22:07:39 -0700
In-Reply-To: <amLScROuY5oleavT@u94a>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
	 <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
	 <04c2eab092885ed738fc87f2db344bca1319a90b.camel@gmail.com>
	 <amLScROuY5oleavT@u94a>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 11:05 +0800, Shung-Hsi Yu wrote:
> On Thu, Jul 23, 2026 at 02:07:20PM -0700, Eduard Zingerman wrote:
> > On Wed, 2026-07-22 at 05:27 +0000, Yiyang Chen wrote:
> > > When scalar +=3D pointer is handled in adjust_ptr_min_max_vals(), the
> > > destination register inherits the pointer state from the source point=
er.
> > > Copying only selected fields is fragile because pointer provenance is
> > > tracked by several bpf_reg_state fields.
> > >=20
> > > Use verifier-env scratch storage to preserve the scalar operand while
> > > replacing the destination with the full pointer state. This preserves=
 the
> > > frame number for PTR_TO_STACK registers and keeps parent identity fie=
lds
> > > consistent.
> > >=20
> > > Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
> > > Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> > > ---
> > >=20
> > > =C2=A0kernel/bpf/verifier.c | 21 ++++++++++++++-------
> > > =C2=A01 file changed, 14 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 52be0a118cce0..085cbd5222737 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -13726,11 +13726,14 @@ static int adjust_ptr_min_max_vals(struct b=
pf_verifier_env *env,
> >=20
> > Yiyang,
> >=20
> > I noticed there there is a temporary 'off' reg allocated on stack by
> > the caller of this function. So, let's reuse it, ...
>=20
> 'off_reg' perhaps?
>=20
> +1
>=20
> > and also adjust the
> > sanitize_err signature to minimize changes.
> >=20
> > Could you please re-spin using the attached patches?
> >=20
> > Shung-Hsi, wdyt?
>=20
> Refactoring LGTM. Feels like the alias check 'dst_reg !=3D ptr_reg' would
> still bite us later, but perhaps that something for another time.

Might be the case, we can extract it as a boolean at the top of the
function, same way Yiyang had it, or just pass as a boolean to
adjust_ptr_min_max_vals().
