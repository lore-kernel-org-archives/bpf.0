Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33431F9A8
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182834; cv=none; b=M+Yfz7nmiRKA7ZfLTvzZq8q+0YcpMpY4EOMRbSr55+IPqpSg8D/C3cq/3BGpgQZ2fVoB25FCzQbQ0mzQV+8Bw9CAXXS/f5K4GjnA1p3bJHtVdXd3DJLqfg5qB51/nVUAzKCiH6+L5vaoAPqXb5llkC403m0EIm8iJN3SNcPdKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182834; c=relaxed/simple;
	bh=/iu4J5gTiWt6jJGDEbidJwCkskeaIh9qKvI83kH7F+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STtuPhtU1wrh4sqhv+IQ+5PPF+jGoC1gYqcC4BbCyMaEOktzjrtb4qG9B6Vkhl3OexdgnD9sUxeRoBWcqkg+y+/a9r45X8gdNSW7IQwlZiOrT/6XgpFOUpjs7cItNy99iLqpzKdyjGEYQDLBRmOMqd0bhZ8kkOIVyt+Ff6eC0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTq/HcQ3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1f8A1tt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTq/HcQ3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1f8A1tt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788182831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L64we0eRRFvyD/p0uOHrFhoOGsuyfMzum+CXMl6CQFE=;
	b=WTq/HcQ34ve3aCNAzm0S+dBQ0adJJ9qyvoeuo8u6BHbny7WR5nW99jnAbq9DMO9DikeHN9
	0AITHaqVI/0/E3OaNFiDFCwTvcYl0JwqSreTNxzpyespOFfX/nx1Ny/j8jxHjv54Dv8+Qh
	Z0KX3cF8vYuxQ3ko2whE//SFir2bVZ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-0kV6rIDBOzuuCraUuQlbgw-1; Mon, 31 Aug 2026 09:27:10 -0400
X-MC-Unique: 0kV6rIDBOzuuCraUuQlbgw-1
X-Mimecast-MFC-AGG-ID: 0kV6rIDBOzuuCraUuQlbgw_1788182829
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cc954a3edso18181675e9.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788182829; x=1788787629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L64we0eRRFvyD/p0uOHrFhoOGsuyfMzum+CXMl6CQFE=;
        b=T1f8A1ttrLlDZmVVQGZN13GrqvyY7Gu8wLlI1Pud1v4Rof35HqMUE+7HcD+rZuFYby
         AqOFLXGgAUmPBIOrGKCsXCOhtYTVGIYc/HjZ0HiEEOCaXXQ1LyNhuFVgqDvZocpPSBR9
         XPNMDaW4JwpNXj89dQf2XS/MoJmwayVkzcwFebVEsMBvLgKmUgXOOPi90fE9U4CflFmH
         TFxaRbvbpMPf++QkFjTJz8Rwh87503+AGo+Dyyb0AjdJ54nbcD9XBVN5cCgejYXfpqUV
         2+/qCPTV8TG2bH5SWN3kt9C8yAAohkvSa0RoF5b0Qf6hkfpxYeroBatN1Tp6inNRmddL
         tliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182829; x=1788787629;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L64we0eRRFvyD/p0uOHrFhoOGsuyfMzum+CXMl6CQFE=;
        b=LJhtGto4Wx2m6tBe/2ZuHMeLnJN22iQ4uxorexHNLST2JkoGz9bhkbfCUXCgje6utb
         PtaCv2WjIXs42VonYelTSXczvpCO6lUbkzxvGQY4HhLHxRpp13HWFi3oDWyF1971mudl
         MpjZOkKG1ur0vwMh722s5rYVV+gwyYPi4JXZ4gqFkqqEDvFt99jC5CBCAZ+UsMaJUVcw
         cTGIvqoMJxkbjCwxoabwFBGpf6kXdpm0U5OjSEZPbW0J/9Hb1ZMa6DIdy6aJCWMYGj7+
         ZiLCQHd2+gfIpQbtdyuMvn2Lv8yjVWI87GbVYhyc28sx0RC+dd+cCLdNeG4Hhj2gpIc9
         8B1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVFmu/hu0Sse+G11ioSZWLzIwrOtBsP6NIWyKv4oHsoF/IrI48C4924YmDZTVyldng2sQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mHsDy68UQrh1ZvvP4+5p6xsZ8L0onIGNjPiJQhVyXwTDX4JMgD
	/X0sYB4gelYBhsIQydfrFW21yGihIXMU46HC0GNnMx47pq1v3bAuR/wFVooxtwmb6VUiGvO5ocG
	COgCcj/d7ZpAca1oVXzKw3OmoZfvNz2sHFe2m34B6qp34yTDH5vupTA==
X-Gm-Gg: AR+sD12R+QmbmhkE9h4q66fC+xBFFoKWZWccXZ8Xjt32rdx5bPE+kVX4e2JhI/VdBXD
	IYbK2+b64/hBOT9FnH5fifG8wE2UR7/y/h86rlVAvshiTg1eovrmaxh/LxxcVnSLu6vynIvv9SE
	Oj9ydpwxO+P2+N2DOIoI78Tts7d+0sZIfrpS0nLPLgCs0d0wpQ/9c6SwgYw/jBCMDpOtMJ2Bp8W
	ebUzK+aEifUrJoKWXV/ET4GbT1KViIa4HnIhXBeULATirMk/youCB1c9hy9Jgn6b9hvDG0J18qk
	WUUqSsiLbwKSjaihLyoeTs5NSxukDejvZWf5LXv+0yFjVeJJSxWuuyuwt6uIm6o/pXQVMERiugr
	RXOxZL6VtliufERHu2jKu+siG
X-Received: by 2002:a05:600c:609a:b0:49b:9032:9c94 with SMTP id 5b1f17b1804b1-49b91bd41eemr421859895e9.0.1788182828588;
        Mon, 31 Aug 2026 06:27:08 -0700 (PDT)
X-Received: by 2002:a05:600c:609a:b0:49b:9032:9c94 with SMTP id 5b1f17b1804b1-49b91bd41eemr421859125e9.0.1788182828211;
        Mon, 31 Aug 2026 06:27:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b961939ddsm133906685e9.4.2026.08.31.06.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:27:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D2A3397C450; Mon, 31 Aug 2026 15:27:06 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Quentin Monnet <qmo@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively
Date: Mon, 31 Aug 2026 15:26:43 +0200
Message-ID: <20260831132648.65843-3-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831132648.65843-1-toke@redhat.com>
References: <20260831132648.65843-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When setting the XDP hints ifname, bpftool would set the
BPF_F_XDP_DEV_BOUND_ONLY without looking at the existing program flags,
overriding any other flag values. Change this to set the flag value
non-destructively by OR'ing it with the existing flags.

Fixes: f46392ee3dec ("bpftool: Specify XDP Hints ifname when loading program")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..8c2f9255b36d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 
 		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
-			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__set_flags(pos, bpf_program__flags(pos) | BPF_F_XDP_DEV_BOUND_ONLY);
 			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
 		} else {
 			bpf_program__set_ifindex(pos, offload_ifindex);
-- 
2.55.0

