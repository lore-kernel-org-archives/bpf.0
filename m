Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757F47CC6B;
	Fri,  2 Oct 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936971; cv=none; b=rzc42k3LD/8aV4wGtL2xQs8nwHqcoVOKOOkLvXqnQEbIH4ThNq/2iVa87vABo2aiSNh1ACrC8y7SbM89OTC2AMN+KN3nQN6g8WHiBaN8bCuwiWOYTHrQhDGX09H/1kUt54LnJHm8g09PMbfA5oLUCuZtRXxEP0OFjdgwJvdIcqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936971; c=relaxed/simple;
	bh=V9pV3ZkkcUvIvt6I4RvKsPeQD9GdKmYVzQtSvVBbOEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NANID+CJR7Xm3OG8ChIyckLOB7VsXY2Qw4STkJ1+MBhh5frRqcpUVWb2kLWRvaKIgS2Ntbkk/YAvHKS49WAqiTq7boBsWVnskPMflJk0kT0A2O6WIdN/qLtpbrlX4Cbr0NdSqOsQT9c6TkOgGDrzlGPV7+wINkTmTBuf2Vhg4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdQd6SpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdQd6SpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D781F00893;
	Fri,  2 Oct 2026 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936969;
	bh=3hd7QozUAtCgPHqY9/nDgR3yxkuQqIYoWENVU+JEeAo=;
	h=From:To:Cc:Subject:Date;
	b=GdQd6SpPFdBtbjy04L7nq/Ny+g0lLZBlDtqsRicYVU2KgU2Amfr8Os26H+CDRc8x/
	 8PZRZXNnr2FYu/Cjd1gGqS0Xc9Pt7dBWdeXi5zmwmDXPLEQY33vZIUWEcCgpzIqjJo
	 9GXj+34WNptzYXbFZHKIGte+9sWk+hoQrHB/E6sU5Y5I6lrd5ECMOph37QlEzSiqAZ
	 nMWBWge3RWohOctGFpVooO20iwO4t6rxLxwu0ct2KfyOUe7aqOu/b+xzEFc+oKCv3F
	 uwyPuFdXpCARvA2E45xaSNsWVRbXKnFtDYoSTxA9iTSZDJLaG03TkuVqrPthR4YnFi
	 JFuixzqEL5VkQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5C9E9F40066;
	Fri,  2 Oct 2026 06:29:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 06:29:27 -0400
X-ME-Sender: <xms:h4e_ar7xU2ShAmF5oNXetXdM5WALbIYV6jCa2jq8K3R2LwVHJA3S9Q>
    <xme:h4e_apsRKhlJsZcx_r9LzBzLh6jtKZxWQ_AwzHf0UxNxLSOZ5t0BUWAPZJNLaix7h
    68FWAlfgwisrtwmgRC2WOoomJuyE7hNB1Hj_X-iAmktxebsYXd2PRY_>
X-ME-Received: <xmr:h4e_apZ7cymsfuucgfwLHSTqqffA-pVMBg2vVQYRkiTFnE5a3o46GoiugqCj>
X-ME-Proxy-Cause: dmFkZTF6ejqiiIIIVBwko2bAePHhMhz1ubb8sHy1I7wDnl97sVe6F6iOH3k2VCcq7bJm/b
    rMgTnQurjYvhCWSK/AfAtC7e+ZILRvjXsFJ/7Fc3WUpSBIUe7Eki5i7Hc2y6sl9LOfzrTl
    YKkL84eHzeS8OBDkblQUiMHhPGEMLPDZZSUK1S7C555OdZYs71SGT1/PCq684Y4FaZL4SR
    WzQ3iqFyTURlTqms7UHgwhgYUJEaao/OwHlAu2ZXamYUJc7YgC59ilDqHCc+5Pln7LJJq5
    Ba+nm2qzU3WqoyzZH7M3OY5gnE9/wCk5VIGcfYTPyDJPtYenTPrTW8PxTq5jZC2JbNh4Tu
    0MyZusGxFLy32BQhC8smcy/Pbmk2DA0+b5p6HUrz3UCYbLOXdROFxxgksCjCt5+VfR8Qyi
    SPC4vdifNZOL3Rh4c4U1unzzvmafTRLa9N+Mf1+CnrUk9G8bFOI6JWF3v0UHaun98hjCrH
    6bFxpXegDItEIGPbOp78/8aOLJnCW0y+HQr6RoKlI9mBmlemwyLotD3MQhSMYSK3+pzp0H
    rvtMiSE79G1s10SJqEgwmSK1rFyK4OWCl+YBfwhE3lhNxbBzHLWjfCaAxMxJxnrLUOmBsI
    LUX7SwkZFTLIuTBFkoi1C2m7QfUxhQ5jMI/dwjfVdB4ms9kZlkLNcDaFtnvw
X-ME-Proxy: <xmx:h4e_aluY7zPRxTnMg-F8AJ6K2crKRbUrECrHPRmTbvKvrwoP2QaCMQ>
    <xmx:h4e_aoCYlxqtG26oZbwf8Jup3DSmwPQeSUO3E-d1lD0zsK1kpQLPWw>
    <xmx:h4e_akPRG_n-rnSS3xuVkIKhrTN6FijyoiEG_msb5oKPiOma2-8I9g>
    <xmx:h4e_aq6M_xF5_i2dlxKt8s5HgsAZ-BAiooeKuC_67roGyJdOvxw91w>
    <xmx:h4e_am1YnOadiB1ZtifsIphdJXYlTNbRL905JGazwCFvnYaQ3nkTfLk->
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 06:29:26 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Ingo Molnar" <mingo@kernel.org>,	"Will Deacon" <will@kernel.org>,
	"Boqun Feng" <boqun@kernel.org>,	"Waiman Long" <longman@redhat.com>,
	"Gary Guo" <gary@garyguo.net>,	"Alice Ryhl" <aliceryhl@google.com>,
	"Lyude Paul" <lyude@redhat.com>,
	"Daniel Almeida" <daniel.almeida@collabora.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	"Miguel Ojeda" <ojeda@kernel.org>,	"Danilo Krummrich" <dakr@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Leon Hwang <leon.hwang@linux.dev>,	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3] selftests/bpf: Use the new NMI_BITS definition
Date: Fri,  2 Oct 2026 12:29:23 +0200
Message-ID: <20261002102923.45846-1-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of NMI_BITS was out of sync after the introduction of
HAS_SEPARATE_PREEMPT_RESCHED_BITS, hence adjust it.

Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Fixes: 3b0e2a22d408 ("preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS")
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
v2: https://lore.kernel.org/lkml/20261001082519.16195-4-boqun@kernel.org/
v2 -> v3:

* Add Fixes tag.
* Add CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS weak symbol because
  CONFIG_* is not available in bpf programs.


 tools/testing/selftests/bpf/bpf_experimental.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2893bf06ff25..a09448347966 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -367,11 +367,16 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 extern int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
 			       struct bpf_dynptr *value_p) __weak __ksym;
 
+extern bool CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS __kconfig __weak;
+
+/* A trivial macro to make NMI_BITS exactly the same as in <linux/preempt.h> */
+#define IS_ENABLED(cfg)	(cfg)
+
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_DISABLE_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	1
+#define NMI_BITS	(1 + 3*IS_ENABLED(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS))
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-- 
2.51.0

