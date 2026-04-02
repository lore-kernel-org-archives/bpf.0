Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918C301471;
	Thu,  2 Apr 2026 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111511; cv=none; b=utLs2i4d4aA5kxNjPSA/mPFUnx8qGLb1wlel8F3FycO+Fqkb6YD5vBAsmMMlF2Wz6jXQsS2wjQdpwWH4Gfx5r3ebfmJYvgRnvT13cdh1yrrI/DCcMEelEb+1NyK4X1RWFhVaLzaBhRTyxUQARf+ovCa75Oms+Ko5SNQUqNPUehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111511; c=relaxed/simple;
	bh=YX13sLn6pbupoGA3DKDkyfLdyhL4r9A4RGREkwORFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Khc9BFQXrb2DnGHRc45auFmEc8m23iw33jdLD4kGgeQbm/y/Y5bmlgLxDbwGwJ4kMbzPIV5ZZprqT8cGiYCba9fK3iGmN8+AxUMXR4DoXCaZ1uQehEiFLsLmoM3rJDNo9nm4/r2y0OhmOgZP6n16C56IZY53FpYDA4PHWktlyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lLNSiJuB; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lLNSiJuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775111486;
	bh=yJVKkdX5pQnrGRfKGg0vycfLU3Us3QpJnv9UWNiLO1Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lLNSiJuBLJFJutlg5k7l3UQnpsu322I6Q1r9JsPxzNJfJU1mwW6JphTew7SFRm9JU
	 clE+7f4CvpEFjaU9OAahNL6lephQtQAvjP+YoLunADIVLAiHtoRAZeqWj2CHY00TAu
	 ttvOdFy/NiJcpEc7S6XJN8TufyX7FRqCA21zbh+g=
X-QQ-mid: zesmtpip3t1775111479taf3f95ca
X-QQ-Originating-IP: MxBasNAkbAgRwNaSzSnPfuiwsuQjUiKlc2gnbkHLLJs=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 14:31:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13942536573944880077
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Lang Xu <xulang@uniontech.com>
Subject: [PATCH bpf v4 1/2] bpf: Fix OOB in pcpu_init_value
Date: Thu,  2 Apr 2026 14:31:15 +0800
Message-ID: <392D7C70CC0B812D+20260402063116.2012398-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5CD977BE2CEFCF6F+20260402062621.2008939-1-xulang@uniontech.com>
References: <5CD977BE2CEFCF6F+20260402062621.2008939-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mv9X8DgfILpCRnt2ZAfWJEs6eTHtrWkqsSPktxx+pCTVu46Foaa9A3rc
	WqPq4vs4Nf+6ZSaQAdaz1in1jXhrUhh91P33+J1siVS7mBzFLRYq2ewBKcfrLng7s/QtoMD
	iKiCqpYSl81JYCEr1FPQXQ5vJoSh29KuuH4exfXrB0rGj2THBmcAloF5HFRJ9Pz28zi227r
	SqfadCgp4RDuACEkH1N/cNzXq9XX8htlgUl7T9gKI38kuFnOL+xtPRAdws0P4sdctaX4/5Q
	vHAgH/EKjKIS9xPBp2rSUsqVNLKYenX3ElH/iQKbRXScujT3EvooFW3yvPYd4NT1ftg3+JP
	IFN1+fvHXG+XpovMNx+HKwyA923cSfaNS4DxPm5LBPyy/s3IOHr1QSxEe5HabwrXEB2lEo6
	GS8/ZlAwMCkHncSa5ektfG2BY3yRCk7xGuteIRT+HvdoMyC3GQQTL3tcVP+tBbpLWbPZph9
	6FgTexg4uzkR5aCsRz2dIHRyqsvV8YELxk3d34zt/spOr0RxplTBoA81PcBsy55sH5MX7jh
	820m27QngQabNxJdYleupupc7IM7EM6EG8Nnba83nAQfZI5EG6EbY55BSonHGJImfVO+uEc
	N/hFqTroIloC4RA+zdPRFpdB9qlZGhxgApqkDgrqcoRKFXfP4b5SY/vUGXTllhW+OHKc+X6
	leOjYv9+HSsc9m4YramkvrEymtFalE0y2pmI5EzM+BvMe+wf7Arl+0UAXrMVKBP/kEaatnP
	5MKLZSOvJU+Kxr+KcJN4snmH8zIe6u1N7//yizOlDmkkd1wAGPdA6mUdAA7PISeBtQpNmbz
	ZumAvDbPiHWBkCa51maLPQEEP+du+7i8Lr1bO6zFAYjZ1/GyV+8YgAjINDP8kDDCLBqX4wg
	JyE/oRiOY/AWTwIio/arDTJrFZpAe3d/UJogNQjgulFXPR154q98vKnoZ46ne+sOJJqHjRd
	Tj1w/bC9kMbSg+eZXO8nNL+pAfq2fbXQW8jT1RLzPyKyN6tyifmbJ5z/8ZP6iz+jvjFyh/e
	yQ/4CY35Yti5txB23NQc9vSwWIDPj2lah6e1JJvpz6AKfC5syrBrxoUYbNmvSwz545Gi8ci
	Lbf/yeYwA1BK+swyZ91MJSiAY94L5dG9Uh8FeC4C/rezuNVRIKloPH+C7HY4Iiy9hAIbBMz
	G5wGLyehHABhUsiDXrfh3z3gng==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

An out-of-bounds read occurs when copying element from a
BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
same value_size that is not rounded up to 8 bytes.

The issue happens when:
1. A CGROUP_STORAGE map is created with value_size not aligned to
   8 bytes (e.g., 4 bytes)
2. A pcpu map is created with the same value_size (e.g., 4 bytes)
3. Update element in 2 with data in 1

pcpu_init_value assumes that all sources are rounded up to 8 bytes,
and invokes copy_map_value_long to make a data copy, However, the
assumption doesn't stand since there are some cases where the source
may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE, skb->data.
the verifier verifies exactly the size that the source claims, not
the size rounded up to 8 bytes by kernel, an OOB happens when the
source has only 4 bytes while the copy size(4) is rounded up to 8.

Fixes: d3bec0138bfb ("bpf: Zero-fill re-used per-cpu map element")
Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Lang Xu <xulang@uniontech.com>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bc6bc8bb871d..fb8123cfa5ec 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1056,7 +1056,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 
 		for_each_possible_cpu(cpu) {
 			if (cpu == current_cpu)
-				copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value);
+				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
 			else /* Since elem is preallocated, we cannot touch special fields */
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
-- 
2.51.0

