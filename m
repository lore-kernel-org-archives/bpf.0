Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705B2D59FA
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318777; cv=none; b=AS1ORzztWG3AVbhXMEOu3jzHU349ptQcTKMGR2WrLATDLy7a/0ByfhNkbyR54+ku+7rR3pnX3MwrZtlO3a4TIBm/4wY5w4GKzzqebpY9V/iFP15rD/J2assERrx8ekF418UQaiv9mnj1R+GVjQQ62t/R4CLhBOZBfyo8Lc5aaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318777; c=relaxed/simple;
	bh=CrbxhHOdTDKHfGkNBwRqk1FwwrPReFotsN4A1rRR4z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvO23YCeaqJ1oHWj+m94iphA5awEj10cOMguur+gL58XFWiftHEadstCAnbkaBp0XXSkDe1OJ+sLN+2nJP8n2KBXx6c6Y0d+9dTo6WooNQoqZ2f1TpLwxCsGv+Ps1lXyyzj1udgr5AE0e2STxm2wMMY1HOC22HBJ7Rs+xLhJOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X71Qs47m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X71Qs47m"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48379a42f76so23931475e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 00:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771318774; x=1771923574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaIDR8djshU4BFSezxhEC7R2xyPi/DP2QW6J2DqR7WM=;
        b=X71Qs47mbZQucbsTD3l4OURliS6Iu+loOPkYZBIN46f0O+OVPFqju3HocFHSnJ1PA+
         0XF/Pa8zhLblkMlX5b15gnGkQwtT8wL6T8OXQFVupIZc6IQM5unLmDwGRjGzogSUmHm+
         uiGTYZf3zBpd/jUARfexePtb4iHW+UwguS80sC7UtXIJKR4NLwWgDEh6zxM+HnDPtfAI
         nqCG+rmTUPCv9ItmEFCq6Vp6rk/rfOfd2SxqkNU5c328sJJpxRPQHSih6MhIkpuhn+6U
         3FyrdzDkF6+4K+KzXkMywBYyPC7DF+w3oP9RTO5y1/sUA+bamG7baan5TcWrHTK3vWw3
         gwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318774; x=1771923574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaIDR8djshU4BFSezxhEC7R2xyPi/DP2QW6J2DqR7WM=;
        b=g/FAJP1gorWAqLTPwEUCnyQxRxFf9vwZWqMLDP8hrJSD6aXTbxZt4KIyTcpzmBvd0G
         bzPUSeQecDutkde8jD4qlzz/g8bc/uLwv3qSnrqp79ONoqeJ4w44SVujqfitaQ2HfS+5
         QYbfTAcan2vRXpcuqtCO0FwBaDXlgwmOwy3c5GEuOC1xdZG6Vv96bB3PBpPtOsZDt4PX
         E1cVUC3GFMPVK7KL2+34TvRU6SOHVWYZG4wyB3XFiVILifP+7LuPOq/WK+ZaMnqx2dLh
         yL6H/RJWxyr7R9JiY5Xx7oetO7S3An2BJaf5s+fAP+2UnxnArz4gOmXabz0+Rp8wD9j4
         0Q2w==
X-Gm-Message-State: AOJu0Yw7Jy+9a5XHWlahipszuy+/s9uAuRL+01vhQrMf2N60yalBMLxB
	uJhk0C3R0jGDxRdapPUAOQYPrbYsx/G5AXXEdn5m2ouE7Mt5tVNpc7xLvKSYQw==
X-Gm-Gg: AZuq6aKEIIn03zil8rT2i5/dNBY9Tz4Et5kfrfKOFcQC+tdJ+TKwXBjokgFlnVIR+dl
	JvSe7767ceJq8iXCcSey2Nr7BvXvoW5hf5ZC34ZMNAVVa6HivNgRwTMJukGl1Rz2vjl1sqbaXiY
	Bayjp+eio5SLnKRy7zYuKOhDRsbxx2ovlz1YMBZOypKsRIOMzfDOe9l+idnWgylHQNs0VwCpIEV
	kvRvLsEDR9s5nVlyrXsijWAOJHss09gfmfTxsO1qZOspPgQBYCqdx7b5jt/0ZWhkVoIo+wt6zJG
	tJA+2btKC4s5BnqEW9PGV9uDybNWrEnJ2PTH5O4dTbV0kLoLPtvS0fepC6si0FeyeHqAbLzfM4r
	gVMVC+G/sa2ZPS3CqUXisqBLzBZJImr1fLmz8UVYamNOAPpJMDkRG2FwmjmAjzJm5Y0Cu9q/OtV
	eF1rCv2dr+awVCYvwHOvA7GSdc6NAbeJg2+Ub1riUWgibKN97n9hxh79+ArTAPeBLpyhwpIn6zz
	Ew37XkWQ1nyNMch+4WKkqpHoIahMuqUcMzSNfEIxnJDtPfatjfFK+Bfw3uCD2Yr9yYiYERZTeNW
	lrjJi0jhqo0=
X-Received: by 2002:a05:600c:3e06:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-48379bac807mr153907235e9.2.1771318774061;
        Tue, 17 Feb 2026 00:59:34 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e003025d1eb71f3ff18.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:3025:d1eb:71f3:ff18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a3f077sm104093555e9.2.2026.02.17.00.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:59:33 -0800 (PST)
Date: Tue, 17 Feb 2026 09:59:31 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf 1/4] bpf: Introduce tnum_step to step through tnum's
 members
Message-ID: <42397d01c3662e85437ffdfa41f5e0c0799189fb.1771316309.git.paul.chaignon@gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771316309.git.paul.chaignon@gmail.com>

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

This commit introduces tnum_step(), a function that, when given t, and a
number z returns the smallest member of t larger than z. The number z
must be greater or equal to the smallest member of t and less than the
largest member of t.

The first step is to compute j, a number that keeps all of t's known
bits, and matches all unknown bits to z's bits. Since j is a member of
the t, it is already a candidate for result. However, we want our result
to be (minimally) greater than z.

There are only two possible cases:

(1) Case j <= z. In this case, we want to increase the value of j and
make it > z.
(2) Case j > z. In this case, we want to decrease the value of j while
keeping it > z.

(Case 1) j <= z

t = xx11x0x0
z = 10111101 (189)
j = 10111000 (184)
         ^
         k

(Case 1.1) Let's first consider the case where j < z. We will address j
== z later.

Since z > j, there had to be a bit position that was 1 in z and a 0 in
j, beyond which all positions of higher significance are equal in j and
z. Further, this position could not have been unknown in a, because the
unknown positions of a match z. This position had to be a 1 in z and
known 0 in t.

Let k be position of the most significant 1-to-0 flip. In our example, k
= 3 (starting the count at 1 at the least significant bit).  Setting (to
1) the unknown bits of t in positions of significance smaller than
k will not produce a result > z. Hence, we must set/unset the unknown
bits at positions of significance higher than k. Specifically, we look
for the next larger combination of 1s and 0s to place in those
positions, relative to the combination that exists in z. We can achieve
this by concatenating bits at unknown positions of t into an integer,
adding 1, and writing the bits of that result back into the
corresponding bit positions previously extracted from z.

>From our example, considering only positions of significance greater
than k:

t =  xx..x
z =  10..1
    +    1
     -----
     11..0

This is the exact combination 1s and 0s we need at the unknown bits of t
in positions of significance greater than k. Further, our result must
only increase the value minimally above z. Hence, unknown bits in
positions of significance smaller than k should remain 0. We finally
have,

result = 11110000 (240)

(Case 1.2) Now consider the case when j = z, for example

t = 1x1x0xxx
z = 10110100 (180)
j = 10110100 (180)

Matching the unknown bits of the t to the bits of z yielded exactly z.
To produce a number greater than z, we must set/unset the unknown bits
in t, and *all* the unknown bits of t candidates for being set/unset. We
can do this similar to Case 1.1, by adding 1 to the bits extracted from
the masked bit positions of z. Essentially, this case is equivalent to
Case 1.1, with k = 0.

t =  1x1x0xxx
z =  .0.1.100
    +       1
    ---------
     .0.1.101

This is the exact combination of bits needed in the unknown positions of
t. After recalling the known positions of t, we get

result = 10110101 (181)

(Case 2) j > z

t = x00010x1
z = 10000010 (130)
j = 10001011 (139)
	^
	k

Since j > z, there had to be a bit position which was 0 in z, and a 1 in
j, beyond which all positions of higher significance are equal in j and
z. This position had to be a 0 in z and known 1 in t. Let k be the
position of the most significant 0-to-1 flip. In our example, k = 4.

Because of the 0-to-1 flip at position k, a member of t can become
greater than z if the bits in positions greater than k are themselves >=
to z. To make that member *minimally* greater than z, the bits in
positions greater than k must be exactly = z. Hence, we simply match all
of t's unknown bits in positions more significant than k to z's bits. In
positions less significant than k, we set all t's unknown bits to 0
to retain minimality.

In our example, in positions of greater significance than k (=4),
t=x000. These positions are matched with z (1000) to produce 1000. In
positions of lower significance than k, t=10x1. All unknown bits are set
to 0 to produce 1001. The final result is:

result = 10001001 (137)

This concludes the computation for a result > z that is a member of t.

The procedure for tnum_step() in this commit implements the idea
described above. As a proof of correctness, we verified the algorithm
against a logical specification of tnum_step. The specification asserts
the following about the inputs t, z and output res that:

1. res is a member of t, and
2. res is strictly greater than z, and
3. there does not exist another value res2 such that
	3a. res2 is also a member of t, and
	3b. res2 is greater than z
	3c. res2 is smaller than res

We checked the implementation against this logical specification using
an SMT solver. The verification formula in SMTLIB format is available
at [1]. The verification returned an "unsat": indicating that no input
assignment exists for which the implementation and the specification
produce different outputs.

In addition, we also automatically generated the logical encoding of the
C implementation using Agni [2] and verified it against the same
specification. This verification also returned an "unsat", confirming
that the implementation is equivalent to the specification. The formula
for this check is also available at [3].

Link: https://pastebin.com/raw/2eRWbiit [1]
Link: https://github.com/bpfverif/agni [2]
Link: https://pastebin.com/raw/EztVbBJ2 [3]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 include/linux/tnum.h |  3 +++
 kernel/bpf/tnum.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index fa4654ffb621..ca2cfec8de08 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -131,4 +131,7 @@ static inline bool tnum_subreg_is_const(struct tnum a)
 	return !(tnum_subreg(a)).mask;
 }
 
+/* Returns the smallest member of t larger than z */
+u64 tnum_step(struct tnum t, u64 z);
+
 #endif /* _LINUX_TNUM_H */
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 26fbfbb01700..55197c9fadc2 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -269,3 +269,55 @@ struct tnum tnum_bswap64(struct tnum a)
 {
 	return TNUM(swab64(a.value), swab64(a.mask));
 }
+
+/* Given tnum t, and a number z such that tmin <= z < tmax, where tmin
+ * is the smallest member of the t (= t.value) and tmax is the largest
+ * member of t (= t.value | t.mask), returns the smallest member of t
+ * larger than z.
+ *
+ * For example,
+ * t      = x11100x0
+ * z      = 11110001 (241)
+ * result = 11110010 (242)
+ *
+ * Note: if this function is called with z >= tmax, it just returns
+ * early with tmax; if this function is called with z < tmin, the
+ * algorithm already returns tmin.
+ */
+u64 tnum_step(struct tnum t, u64 z)
+{
+	u64 tmax, j, p, q, r, s, v, u, w, res;
+	u8 k;
+
+	tmax = t.value | t.mask;
+
+	/* if z >= largest member of t, return largest member of t */
+	if (z >= tmax)
+		return tmax;
+
+	/* keep t's known bits, and match all unknown bits to z */
+	j = t.value | (z & t.mask);
+
+	if (j > z) {
+		p = ~z & t.value & ~t.mask;
+		k = fls64(p); /* k is the most-significant 0-to-1 flip */
+		q = U64_MAX << k;
+		r = q & z; /* positions > k matched to z */
+		s = ~q & t.value; /* positions <= k matched to t.value */
+		v = r | s;
+		res = v;
+	} else {
+		p = z & ~t.value & ~t.mask;
+		k = fls64(p); /* k is the most-significant 1-to-0 flip */
+		q = U64_MAX << k;
+		r = q & t.mask & z; /* unknown positions > k, matched to z */
+		s = q & ~t.mask; /* known positions > k, set to 1 */
+		v = r | s;
+		/* add 1 to unknown positions > k to make value greater than z */
+		u = v + (1ULL << k);
+		/* extract bits in unknown positions > k from u, rest from t.value */
+		w = (u & t.mask) | t.value;
+		res = w;
+	}
+	return res;
+}
-- 
2.43.0

