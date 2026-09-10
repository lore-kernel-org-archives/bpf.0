Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600B356766
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065162; cv=none; b=dFl2cnwZOax/fCSEzZq6trFNKGvk2+9eW5LfYpEH8Y+CY9kSTm0LUK38ipLUVLBnUPdodJH0pzg6K3VP5Z1XH1FpJjrNvBS0L3c/OFhjk/q5bJAFhvJtbLq04Vi1uJI30f3lSsN4F1n62b4fhi7PctIWLAtiMxNEctdkgnViCYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065162; c=relaxed/simple;
	bh=wqIXxPryIBD+qpnTAML1VsX5jPCUetcLu67p2mKXcRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dw/zQGMwgOAZNUqs6huVT4y6cVe+cMifJ6ZQheYa20h8yn6dXFnAbWYDWpaj27SNetr9mjUm5oSLSx4V6Tymz8quY+UkxBWiAl8qdYpZLP4+BwwozMJAjnIKmHNm1dfiOBKi3aAgjrLQsY2wT4QhSeKZ2sxgXmicJahteUCovOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7zp5bDA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKsNkWyp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7zp5bDA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKsNkWyp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789065155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSgNGI7auaX5Wzahh0Ju110gqPyYVLHgiTEYAP31fQs=;
	b=R7zp5bDAArZHBj1LbxFlmN74GYTDbt6SbW5v04/FzbP/Gjsj9cd37daPDSyAvb4pybiBp0
	yMBgDYdx6sae5WenC2gRqVTcv8xh5hl1aPBUTNEyglYnoW5OMxwUQ1cYkSCCUXjlE43ypp
	cPYqBycRF8CtwnGGbx3XPijSRoQGlCw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-LEmukXAxP3yvIISK_Bv8NQ-1; Thu, 10 Sep 2026 14:32:34 -0400
X-MC-Unique: LEmukXAxP3yvIISK_Bv8NQ-1
X-Mimecast-MFC-AGG-ID: LEmukXAxP3yvIISK_Bv8NQ_1789065153
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so2042475e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789065153; x=1789669953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pSgNGI7auaX5Wzahh0Ju110gqPyYVLHgiTEYAP31fQs=;
        b=XKsNkWypy/aT18GXJ67u30F6uWeiRx35nrqsY8Q9AHiVJVhkjByeHMH1bY63GAgWLK
         urZ/1zKIf8ryG+K5edD3lPau+RyHomtdsU+7sl4RdtN2qA6Le+jR38oXfK99OxD89tL6
         d4LHQHFjn3wqvnJjIRMGauWiWoIweM1Sn3zI0eiRCVL0GZzR6t2cynb7dNbbfhKe3ZMV
         VqnS0IeYPTRrMRrSRSxbnNc/QygVxb4AZtD3LlYzjhF2NmsbTjs6eY7xkqlw+YNpBXNa
         zCOoRHzVnw+gwayk2fP2tzD1V+/C8BJsllnbs5qcwsEq9Krxp1ZU+5x+fgBHamHfmm7q
         W2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065153; x=1789669953;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSgNGI7auaX5Wzahh0Ju110gqPyYVLHgiTEYAP31fQs=;
        b=hfcsKFqa8fLgTXuOuy/zzWWgk/ehiolyC3XI1WAufzfc845Kr6N/hP1sumRrUxOYX8
         nNz0hG0iHW+riRfiUyqKm5bVpmqi9Uc5Zt1gXPLEKeRfu+6DqBkuh+eiHq+LLQfg3H2n
         RXWkwZFt5ZiYan05KMOPiScGIyU0Uaarf5xfNmi5ilRiir+39cpdfa5zYXuf8Pv9qad6
         euqStgVAlU/VMesFkO99W53BRfUky0mXvtqyhLTYB1ZUTi0oGFKC9tXOUhmuz5dD7zqW
         v1MqwFJ95Zje9tPRqBSx0QqiuQesNCdlNfuUnpyjs3RnfffLBIj4abHFmngvM/El41Lj
         dgxA==
X-Forwarded-Encrypted: i=1; AKwUvBz5GdlVkEkbUHYrtSXAB2QhVfcodwbdcq8ttJz6hpmqvn7e41YMfRSuaijHydeoaywxPhU=@vger.kernel.org
X-Gm-Message-State: AFuF++mCgkJJEWoemugezo+/Mk4inNLAY8pYvsjhnfpRc7PVblRdunjA
	/7dVJribxJp94FFoJ2+dxwKTzusMf+OOyqLhTeluhFkLlhJjPrSUB/+153zFgJg2JlY+WyksctB
	JMTgKme+PimencxQ5vtRtMLOT/XV0ih+QLGi6iMaRI+iYoEWED0DilA==
X-Gm-Gg: AYBFou2sOVEK3gPy5yO1SKpnR+NSn4XUWjv9NNprmdbggeRzjhTQI07WnRdm8ed+9ys
	nwY1PN8yqmM5gFmek+LhP24psLbVRtdDzhLckFDJx2oKr6n0NdFJ3dBHlZEew5gG9o7rfrdniru
	xeK3UqrS4ytR82mEoi9Im/3gnjHsjTjv+QD7oimGrTEztATi6A+r8vqg8YeFCGGiygNGvOzag4G
	ue8tt3NOTohagUrTFYPz5uzA5U6wChqoWPbdhr+JIegHYfTcPJmRULEjvw7lJUcMhWYvNp1QiIO
	En4gNTWR7e/hcrTS0Bj2k4bv8MZCsr9stcu2vklvlQ9PgjARFcl/JgSToADXh0eSvIsIBx6TQ3Y
	sY2NNEsY4O5sg+bxHB/6yYmJ1
X-Received: by 2002:a05:600c:1f8d:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49e6198933cmr3974985e9.9.1789065152944;
        Thu, 10 Sep 2026 11:32:32 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8d:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49e6198933cmr3974615e9.9.1789065152598;
        Thu, 10 Sep 2026 11:32:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a33d72sm2629355e9.2.2026.09.10.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:32:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3AFA69B97F0; Thu, 10 Sep 2026 20:32:31 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 4/4] bpftool: Adopt bpf_program__add_flags() helper
Date: Thu, 10 Sep 2026 20:32:17 +0200
Message-ID: <20260910183222.307208-4-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910183222.307208-1-toke@redhat.com>
References: <20260910183222.307208-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adopt the newly added bpf_program__add_flags() helper to
non-destructively add the BPF_F_XDP_DEV_BOUND_ONLY flag to XDP programs.

Acked-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8c2f9255b36d..6ab911e82155 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 
 		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
-			bpf_program__set_flags(pos, bpf_program__flags(pos) | BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__add_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
 			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
 		} else {
 			bpf_program__set_ifindex(pos, offload_ifindex);
-- 
2.55.0

