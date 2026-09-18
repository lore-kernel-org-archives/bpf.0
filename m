Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA23B42C0
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773232; cv=none; b=KMQUx65yISQ3E2IMwju/uxC+zir3SOg9S3GS0BlEhxbPiNa1imBUBIkrV64Wa9xM4x6JMuMC+fbz1yBrIG+WcELfxurkEz/P2EKZZlI0PKzZuR2jT0MTGKpDKYBCIUsoQlLL5V8gceOEZSUU4KiT6ITIW6fHfpQzCuO+Nnp1tmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773232; c=relaxed/simple;
	bh=6y+7czlKK/tta15hugGL0Z+zCEcp7uVIfBypdcFDsqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rljhwc0IuyYIBGBw9D70b+FbpSD5adkR2hoDjTuApAuJ9Ij5Q/Kt0isROIW0S93StE0M6MNaXKqQiM+QK9JhhGJJ7FXyGyrMd9DtSCh3Cf+o3mUi6J2skNuv5Tbw9iQNczKdarL528cl1diUsfvV+6ti2g387qo1iQVGLip7c/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaonM2oS; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaonM2oS"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso1178178a91.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789773229; x=1790378029; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6y+7czlKK/tta15hugGL0Z+zCEcp7uVIfBypdcFDsqA=;
        b=qaonM2oSj9rA2vRwFBptu1pWvPBeFHJO8naAMlXCz2DklGd4IakjylA3t6RGSN2zQn
         0GbnXR9rAmJ3VzgYTk5wp98Fm3m4DzajbCfxLr/p/AesoRNEF25C+7A/QZNjexcQh5Zb
         z1yw2QpAAcc1X6T+x9377dPXOudWIYih/Su8DStT9sljgXqDCsyJ9xgSQkYki95YTKGJ
         AC+TZH7wftmcRFiCipP3UhpPmBlVBAp9QSaM4Jv2xG258fBC9/FhKdbeAQDCmCaJZRm3
         2upBg7KoUSGNPioQTTtN32x584ze20uhkHlLAQEkXPO2w9uOIQS+LwUjxhAy7Gqbe1N+
         TalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789773229; x=1790378029;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6y+7czlKK/tta15hugGL0Z+zCEcp7uVIfBypdcFDsqA=;
        b=rpAjj8HTHcipA9Lv8XvWSbaGOlQXyZhu8BMwVZCB4V9KArniF6YhvqnKO+hCa7oceq
         utk0kQR2416yfIT1KamKh5SovDvcbM7h/XuB7VlbhxgePxtk3SVVDsqoUlJf+XYkRfwt
         l0W43BUZHX5N86LRbvLRlrcIME8xDF7MVze9qzxeCD2ov3J0qiEzXNiTQLRg3AlWcbJf
         jElqdYDQxIDHBwo+C+pte6Ry7rlsl5JOaGs4lDLfpHHx+eR6TCSy7F7o5sW2aehBJ9xi
         qGRZdf+/QN3VU2qeguxbtzm4O8cwjGUYWur3FcHxjPuf8ytZ//vt9R+0hisrEE/4n9G0
         aknA==
X-Forwarded-Encrypted: i=1; AKwUvBx+hJI+IHdrwgUEq6RgyvsRluXAUL9K2/tUy4VoQwn7cgOB5mxw6bT0sGZnHYNk9Y2L7qw=@vger.kernel.org
X-Gm-Message-State: AFuF++lHc5NOTpA9PsTpM8iDUEUHg5MY/D2W0zkKjenGLAFDBuRouj1N
	Dji0qmXLIoVaQlcEzenyRMy20C0TvcknhcFGC122mSDQWMESDBmInuk4
X-Gm-Gg: AYBFou2AVaJT/Uq2MzycDhKk6IOi16CK3hB1DgCgetckpUcwB02Grzc6vUZ9JUmf7CA
	o1lfuTRBuemzn+wOQURN8x/WxSTDqwfPwBU6X1j28rze7iAQIs1LiK41ESdenLH2qWnJGLvdNw6
	HvEAnryE6EoCH3GJcaIPKxmM9Gw15aYUHTMZYKeTlNcd64DcYW5GrPwU5FM1Xvw9K30IVVr13nF
	/ijvjY2LZ/9MaCqz98SeLncNA/Fv//7rCZ+o9x7DZdNcI2TtZ3w07jHjOhTGbK8sWve0fVxb4Rj
	WF2g8hJa/3kdMn4yfkWXo/MWNjiT9FpfIeuNI+9ufmAaX6YOn6RoPcRh91HwNfRbpBBJs8K9FSI
	wbAzCGsSh1St8kCSF9MI+bhnaUTQeqBUGtfCXVwKhxP8PQU+v63k8kSni81H5Zp3R5rWuB1D0OY
	XUZ3/T2Qj9K2NM7/sWa3UAfmU+VPgKq0cwKp1UO5/KUuB1fRzSmWpAY4NIBbz10qgRoF7MIOQdI
	Q22sY/KYNDRvK9Am0FTzV0JfYYa1lfFus+h4LHZIY6XuCv62zuzqNASzg==
X-Received: by 2002:a17:90b:4a4e:b0:39e:6c69:34d3 with SMTP id 98e67ed59e1d1-39e6c693665mr1503726a91.55.1789773228966;
        Fri, 18 Sep 2026 16:13:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32f16f9csm1690414eec.2.2026.09.18.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 16:13:48 -0700 (PDT)
Message-ID: <6289e47f004b8b0d5ce55143fb1d55f7306856c0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Fri, 18 Sep 2026 16:13:46 -0700
In-Reply-To: <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
	 <20260910164635.459558-2-vineet.gupta@linux.dev>
	 <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
	 <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 18:17 -0700, Vineet Gupta wrote:

...

> > =C2=A0 static bool regs_exact(const struct bpf_reg_state *rold,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const str=
uct bpf_reg_state *rcur,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct bp=
f_idmap *idmap)
> > =C2=A0 {
> > =C2=A0 =C2=A0 =C2=A0 return memcmp(rold, rcur, offsetof(struct bpf_reg_=
state, id)) =3D=3D 0 &&
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check_ids(rold->id, rcu=
r->id, idmap) &&
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check_ids(rold->parent_=
id, rcur->parent_id, idmap);
> > =C2=A0 }
>=20
> > Also even after above change to check_scalar_ids() the check_scalar_ids=
() is still
> > no equivalent to check_ids() that regs_exact() is doing.
>=20
> ... Right: reverting back to what we had before.
> FWIW Eduard had suggested to use regs_exact; I'm not sure if he had=20
> something else in mind which we might be overlooking.

I missed the check_scalar_ids() vs check_ids() difference, sorry.
Also, yes, let's squash with patch #2.

...
