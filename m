Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517553D75A2;
	Mon, 20 Jul 2026 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540098; cv=none; b=KWV7mtgVYPVHvLbaus+cwi58sLQHBKyjH+7dXFnqiHdpyMwRSpBaNfFHrxQeP8l9cqXVsu2CaP5voRQJ4AndfTIuUFBIt3GVkcAni/RK0a2GgByJlQUrDwuS4vr99lxIjnMiKjMB5mHzwTopEYgs5ewazCHTDSc56SxaQcylqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540098; c=relaxed/simple;
	bh=qdVXGI1HLToc0Ta28J+Ik5fzoyHaFdrVcj71f3lCDaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrQOs1GZOLdJ8FEAMdvRQl4096/mad87Q2v2vVIKksH/Gu/HXc79CKiwZkCL3MPX2D05TFYTkVynOBog7/URTtEA2NH3aRP6XLzGdY/STR0X+PWNGZgF8TEH3vXgB0VWjtWeRBUomeAdLM7gK5VwbvEHzYZIgLNzaVDfSVoQBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE29hRwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE29hRwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E841F00A3D;
	Mon, 20 Jul 2026 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540097;
	bh=8HEZ0jJv99WpWqbb2o0FPUdYsrdjjV1tk0iDO4gqEW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NE29hRweMDLceETt/Ju/GZGI1POgRzgLEtxxlp4VXu44XhAgSvfIBzPYXnINwfo0I
	 1sNQt3akWm9G6zUcsb0mCqHZh54+WRL9uC3Z2zgz2mLHmrerkTgAxai2tjfVd8t5vW
	 DHML/MFp6lYYs/pZPcZDu9VsTzUdVhvR4J3bWlPY9B9qUDRcjFHaIR8SyhDEnU3mDW
	 4CZvp+eCXjceuP9y0JeQkiiwbYjOQD/p1PV+cB0urreJqAQffXrGBpteipNxUHEcsq
	 9euBN1eO+JL5wl6q+Npmy3eRPlYz+yai9f9T8tKGVEpZAMHw4OJcvuc+WONbzfr3K2
	 uFu1ugBNwTzdA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:41 +0200
Subject: [PATCH 18/21] binfmt_misc: add the 'L' loader substitution flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-18-ddb76c9a508e@kernel.org>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
In-Reply-To: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3433; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qdVXGI1HLToc0Ta28J+Ik5fzoyHaFdrVcj71f3lCDaw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm7W2rKYafEE78BL+6xixMza/7Zb/hX+z/TnEP9zj
 bCZk7vqO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS1sDwT+995cEGn90l3G36
 axKW3D8X2+K+zDr2Sk5ffaXH6idsGQz/g7VKVKVL2c8cOiH81V3/r9WC77UNaU/vJTRct5oyO9O
 aBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add the first activation of the PT_INTERP substitution machinery. A
static entry registered with the new 'L' flag no longer runs the
registered interpreter with the binary as payload. It stashes the
interpreter as bprm->loader and declines the match with -ENOEXEC. The
format search continues in the same round. binfmt_elf claims the binary
as a fully native exec and substitutes the stashed file for the binary's
PT_INTERP.

'L' rejects every classic-dispatch flag at registration. 'T', 'P' and
'O' have nothing to act on (no argv splice, no execfd) and 'C' is
subsumed (credentials derive from the binary natively).
'F' composes and is valuable. The substitute is pre-opened at
registration time and immune to mount namespace changes. As with 'C',
only trusted interpreters should be registered. The substituted
loader runs with credentials derived from the binary.

The interpreter open is shared with the classic path via the new
entry_open_interpreter() helper. Open errors fail the exec as they do
for classic entries. Like the other flag characters 'L' cannot be
used as the field delimiter or the flag scan would run off the
registration buffer.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 1cd30dec3fab..ee48dab2638a 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -51,6 +51,7 @@ enum binfmt_misc_entry_flags {
 	MISC_FMT_CREDENTIALS	= (1U << 29),
 	MISC_FMT_OPEN_FILE	= (1U << 28),
 	MISC_FMT_TRANSPARENT	= (1U << 27),
+	MISC_FMT_LOADER		= (1U << 26),
 };
 
 /**
@@ -73,6 +74,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
 	{ 'C', MISC_FMT_CREDENTIALS,	MISC_FMT_OPEN_BINARY,	"credentials from the binary"	},
 	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
 	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
+	{ 'L', MISC_FMT_LOADER,		0,			"loader substitution"		},
 };
 
 /* Look up a flag character, NULL if @c is not one. */
@@ -475,6 +477,24 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (flags & MISC_FMT_OPEN_BINARY)
 		bprm->have_execfd = 1;
 
+	/*
+	 * Stash the interpreter for binfmt_elf to consume in place of the
+	 * binary's PT_INTERP and decline the match, so the search continues
+	 * to the real format in the same round.
+	 */
+	if (flags & MISC_FMT_LOADER) {
+		/* A native exec has no argv slot for a staged argument. */
+		if (bprm->bpf_interp_arg)
+			return -EINVAL;
+
+		interp_file = entry_open_interpreter(fmt, interpreter);
+		if (IS_ERR(interp_file))
+			return PTR_ERR(interp_file);
+
+		bprm->loader = interp_file;
+		return -ENOEXEC;
+	}
+
 	if (flags & MISC_FMT_TRANSPARENT) {
 		/* No argv is built for a staged argument to land in. */
 		kfree(bprm->bpf_interp_arg);
@@ -771,6 +791,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	    (e->flags & MISC_FMT_PRESERVE_ARGV0))
 		return ERR_PTR(-EINVAL);
 
+	/* A native exec splices no argv, passes no execfd and needs no creds. */
+	if ((e->flags & MISC_FMT_LOADER) &&
+	    (e->flags & (MISC_FMT_TRANSPARENT | MISC_FMT_PRESERVE_ARGV0 |
+			 MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY)))
+		return ERR_PTR(-EINVAL);
+
 	if (*p == '\n')
 		p++;
 	if (p != buf + count)

-- 
2.53.0

