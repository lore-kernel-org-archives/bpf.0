Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C8431A3D;
	Thu, 30 Jul 2026 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418489; cv=none; b=ae75ZAQLc7aODQLah46nBWXjIII4fNoGIFE5JnE9ZKk4wCFLLgdzHyrU8XK2HKEYksdBDm/KuAYjKumRkI1XYEs5iYXlLqilNGhTSWyeRH2BrUfElapulQ9G3nq3m0ADU7PGvHrTImIDXpGpMZ4Y73Y6CRAetx/R0pnrEoMR88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418489; c=relaxed/simple;
	bh=KqwlQlXuuUZaCVG8Wlf47Bg4tzNNtuMbADQ8RYC4Dk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BdHDCTZY9bEkNQpteHSeHHH+yERQwSZg04YZtS40XcctkbWlMHlM556vnntxqXx3vkuJ8R6DUTka+lBfpAdt2tkAuamLqkcNiySe1JBQ5l/WVmX4gCsO5zIYIMjJbsJPd3JEw1h2fu7i5vHD6rExnZp7p6tff4sp+9H7ujPwxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlr/K0cv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlr/K0cv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA891F000E9;
	Thu, 30 Jul 2026 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418488;
	bh=g+4qlEqb1XkEb9wx8BpIkiKnPP0oKugCGAugz1nl39c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hlr/K0cvCElbazREsM7+d5QYfY34tfXw2CB/QSocANrVOVz+5ze6zbePvlLiegY7k
	 N5dulF+2TTzcMYhZ9cIXPCZxacX7UWMvntx6Vgk2hOYWQcbQ8CAMNkfc+h39y4ysDw
	 iUZZhzAEYpINc7KYGY4dQdf2g+2GLCYcdmZhvIM1zw2mejuYkGsOJKTWrZgzFzwIlW
	 HsFJvxLn+G+1kMe/OJnr0gSTsLR2snsxdZlNJbGpGMT44ZGSHa2uY8VZFgsyhg0KT3
	 3WWxTgTU04VBjHAhtKTgznNSRcDU5NAGbklOYxPh3QdTJEK1TX1fdO50MPxIiT1n27
	 csAVSPKIFr1+g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jul 2026 15:34:04 +0200
Subject: [PATCH 2/9] selftests/exec: let binfmt_flag_supported() return a
 bool
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-work-binfmt_misc-preopen-v1-2-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KqwlQlXuuUZaCVG8Wlf47Bg4tzNNtuMbADQ8RYC4Dk8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlB707uYxFWeDKXKfS5HtZW927jzklpV8IkP91ejbb/
 Q3lKrnRHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMR/8HI8GWv6ZNvPeddP5S+
 fW76l3+Nc+UsXp2VVZPMk07W6+moFTL8FQ6oZ+z4oPeiOiZlp1r67r/hAadWr+KZs/zvd/mr14/
 EMAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

binfmt_flag_supported() returns 0 when the flag is supported and -1
when it is not, so every caller reads backwards:

	if (binfmt_flag_supported('T'))
		SKIP(return, "kernel without the 'T' flag");

Make it return a bool and flip the callers. errno from a failed probe
is still set for callers that check it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/binfmt_misc_bpf.c         | 2 +-
 tools/testing/selftests/exec/binfmt_misc_common.h      | 6 +++---
 tools/testing/selftests/exec/binfmt_misc_transparent.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/exec/binfmt_misc_bpf.c b/tools/testing/selftests/exec/binfmt_misc_bpf.c
index 069768a66ba0..c6f5e8f34985 100644
--- a/tools/testing/selftests/exec/binfmt_misc_bpf.c
+++ b/tools/testing/selftests/exec/binfmt_misc_bpf.c
@@ -258,7 +258,7 @@ TEST_F(bpf_handler, transparent_dispatch)
 	char src[PATH_MAX], cmd[PATH_MAX + 16];
 
 	/* Probe for transparent-mode support via its static counterpart. */
-	if (binfmt_flag_supported('T'))
+	if (!binfmt_flag_supported('T'))
 		SKIP(return, "kernel without transparent mode");
 
 	ASSERT_EQ(artifact_path(src, sizeof(src), "binfmt_transparent_interp"), 0);
diff --git a/tools/testing/selftests/exec/binfmt_misc_common.h b/tools/testing/selftests/exec/binfmt_misc_common.h
index c6900ded019f..e8d67908dbc4 100644
--- a/tools/testing/selftests/exec/binfmt_misc_common.h
+++ b/tools/testing/selftests/exec/binfmt_misc_common.h
@@ -117,16 +117,16 @@ static inline int artifact_path(char *out, size_t sz, const char *name)
 }
 
 /* Probe kernel support for a registration flag with a throwaway entry. */
-static inline int binfmt_flag_supported(char flag)
+static inline bool binfmt_flag_supported(char flag)
 {
 	char rule[64];
 
 	snprintf(rule, sizeof(rule), ":bm_flag_probe:E::bmprobe::/bin/true:%c",
 		 flag);
 	if (write_reg(rule))
-		return -1;
+		return false;
 	unregister("bm_flag_probe");
-	return 0;
+	return true;
 }
 
 /*
diff --git a/tools/testing/selftests/exec/binfmt_misc_transparent.c b/tools/testing/selftests/exec/binfmt_misc_transparent.c
index d0cb845df1d3..2ebf73de8018 100644
--- a/tools/testing/selftests/exec/binfmt_misc_transparent.c
+++ b/tools/testing/selftests/exec/binfmt_misc_transparent.c
@@ -56,7 +56,7 @@ FIXTURE_SETUP(transparent)
 	ASSERT_EQ(create_target(), 0);
 
 	/* Skip the whole suite on a kernel that does not know 'T'. */
-	if (binfmt_flag_supported('T')) {
+	if (!binfmt_flag_supported('T')) {
 		ASSERT_EQ(errno, EINVAL);
 		SKIP(return, "kernel without the 'T' flag");
 	}

-- 
2.53.0

