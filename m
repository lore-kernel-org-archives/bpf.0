Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9A2868B2
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769875747; cv=none; b=kZX87sNKyzZDMscV/kEstdSMVUDTjZbEJp3bRYL65GyLKttmoACCfSKoJGfxzKdjUNiz1fyN7nJ9s9aeu6US0oW6pbRJjbqrIu1j4WjmrDIomCN81MMg5MltS+v0aglY9TyEGk1VVEFuP0PSTxMYrzp9LgCyhzIklK6RFJqOUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769875747; c=relaxed/simple;
	bh=U7GV28I5Pnt6+fi3NGCXq2+oEiuFkOevXvjYMeCNdKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoQeKLKDuDTQOkXNc+GddjXW1hwFVbdn32pqvJzfzBYN039SsCwsj2hMxbSQD0TGsVGgHF9c82MCxhBZmeszANgZDd0q1ceEadcp+tBz/YAp9XDyqUC9DS/ZD5OAPYXImxY7z2EcAWTFMJ7G6sJyCyv0vtKVMDX5NuHOcccEUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYhyzwlb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYhyzwlb"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359a302794so2136250f8f.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 08:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769875745; x=1770480545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3K0Su/GnhpJboAF70b6wT52wzdV8TnyIX/zYFlef7Do=;
        b=kYhyzwlb0q31xJwbkZt41CpMFKxF32bMAbdtxQcwt6MjfBLv/HfUcAOn6oLDa7dvEw
         67rTzaJ+W7Stz0abAwd0M2hbBcDyalUWb2Zsk7nf0wdUkz8w1ozD1KI8//gaZLNRuwLX
         jP+jkqwrFJQcZ4BDnzk1wsOXfz4OnL2fMl/1zHISyOINmxT8JJDlVBN/cnqhagHz0zQ9
         XS0LavTtXhPyjmtI6T0XoMrbS4/dpEIgnKV2NGjFewQmHOD6cWt+HUQkQ0kMNr+65OfD
         fnvO/hO5eQ15sWiSZ6/XQ5622Q5IlKWdJIjD4Nsnw1/XXdminrjvfBxeqiFnoev+DKTV
         iFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769875745; x=1770480545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K0Su/GnhpJboAF70b6wT52wzdV8TnyIX/zYFlef7Do=;
        b=q0sZvj1PpW42+SDVyz1GczgFUJglQzmzyfA4rRs7ifTn0ot4bwL88b1RSayE2b7AVv
         bADGZfe/8s0QYF/Mk4xsrqp5eWeqq5DG3Maj8MsOhwx65PHVIfJsxqwkw2SyYd3LBkHi
         K1Xjjj2qG4+ZOtk+IH2H7/f9E/zSy1dOGjY36qwtkMqzFZa+Q31W53ZOIjYOTd8vgNW0
         /Fj3PCQgnSd4esqW3kj1Sr1qDr8ZXgGCRz0zjBWjlgXEcto1+2lhvG1dqQdr8xAaAegX
         CE6GomvFS/G1jC3fTyBSp9Lp2e6voyoYvm6z0MuPulx3uO4bP6EqPXOyWp2PnJEtpklQ
         Wgeg==
X-Gm-Message-State: AOJu0YwOKBC1UtEOtLx/OW/Xs7qcTbsTK/84jLX2NRxuAO3fPvf/XxXa
	39wgx/MM1lig4SUxLze5Wv3Qz9pmdkzYx2w/84DtvZiOjIEm6saoBjDCl0mEkg==
X-Gm-Gg: AZuq6aJlqt/INdz5jv2ToX2hTdfjRXGF3sq8nUWs2CCZJdC2g5kflfi5zu7ANrpSabh
	HfqZyg5BChjh7wG/+VL8DJH8kXx8ncQKaT9BEPR9iSeRbGIZH7wwSe8Fkj3052c09Jly9gAqk+k
	/PdrX2oOF9IWRR+rdRJi42sXDdlxqMqmnScWl/XVPqc0U3Fj+MLUI8tI5SzWJFxe5+8jQqxEWzC
	3kQvWPApr8q4vQhl9ywTId0pANykMIDuoDWcyw9zg1dblVZbj0lZZ5KLwP0BVIAySzOJLc9842P
	fnRiFq73z1RDnOkiIwxibDV3sK9pg8mLLdyBFHGCFU47vvGDQA2HOAI9DxxkSK7MJff6+vvhF84
	jTF6m0an1F3q4vu8+WJnnnoVLHB9AJISyAUsBcyTQ/j4Af7OMLJHrMqLGi2Ev+df5blnSbD/cZI
	vY506VSwGL83q2+IaQarY27/yvzKENI2y9jtKMVri05MwTs95QnHyfPbnZN18oP+RQnoQvxygG6
	OVM/mqPuhv9FmG7qqASzVVPLUw1Q9YVmBrprOTdjv5ZOLN6oMo/ZGJ/Xj/TRFmcA/e5tMtIgHA=
X-Received: by 2002:a05:6000:3110:b0:435:ab90:6f34 with SMTP id ffacd0b85a97d-435f3a861c9mr8201264f8f.16.1769875744588;
        Sat, 31 Jan 2026 08:09:04 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e008252ebe287038db7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8252:ebe2:8703:8db7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce58sm29920938f8f.20.2026.01.31.08.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:09:04 -0800 (PST)
Date: Sat, 31 Jan 2026 17:09:02 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Test access from RO map from
 xdp_store_bytes
Message-ID: <4fdb934a713b2d7cf133288c77f6cfefe9856440.1769875479.git.paul.chaignon@gmail.com>
References: <9fa3c9f72d806e82541071c4df88b8cba28ad6a9.1769875479.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa3c9f72d806e82541071c4df88b8cba28ad6a9.1769875479.git.paul.chaignon@gmail.com>

This new test simply checks that helper bpf_xdp_store_bytes can
successfully read from a read-only map.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_xdp.c        | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp.c b/tools/testing/selftests/bpf/progs/verifier_xdp.c
index 50768ed179b3..7dc9226aeb34 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xdp.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xdp.c
@@ -5,6 +5,14 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, __u64);
+	__uint(map_flags, BPF_F_RDONLY_PROG);
+} map_array_ro SEC(".maps");
+
 SEC("xdp")
 __description("XDP, using ifindex from netdev")
 __success __retval(1)
@@ -21,4 +29,31 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("XDP, using xdp_store_bytes from RO map")
+__success __retval(0)
+__naked void xdp_store_bytes_from_ro_map(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;                                         \
+	*(u64*)(r10 - 8) = r1;                          \
+	r2 = r10;                                       \
+	r2 += -8;                                       \
+	r1 = %[map_array_ro] ll;                        \
+	call %[bpf_map_lookup_elem];                    \
+	if r0 == 0 goto l0_%=;                          \
+	r1 = r6;					\
+	r2 = 0;						\
+	r3 = r0;					\
+	r4 = 8;						\
+	call %[bpf_xdp_store_bytes];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_xdp_store_bytes),
+	  __imm_addr(map_array_ro)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

