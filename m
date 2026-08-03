Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F8402443;
	Mon,  3 Aug 2026 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759327; cv=none; b=HkgzTFlql04NRmafU0zCgVexW7bTgnoA4/oyhw8U0knCsT0PxiSLmHeMe5LeMij0tXTxtKWPti/Eq7Cxr8HtOmLsfkC9roIzSOQh1BieQMdXSPzgwyH0eeYR2K1xdPq0tPdg9XUCjJpjWpVuBcZ86qksbOoF7/+f2NeVHziO4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759327; c=relaxed/simple;
	bh=arBQ7R3qh9fuo1bIT/ltszB5Q9NNONeVHQeT13NTzno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OgrXYHlLCUVELpgJYW6nctgw0adUW+umfV+UAk6p5ExTLRWR1U5UH8RjHfNNiMk/GzyyPewjejMvZIXYBSxqvDXlUfeQL3Zpj5qq9zm7KYjEsVWYfqYZO6Q8cQfSejZa9FqASiNYh9uIJPLM8YS65P84+V7WD1kFWuqQNYmQY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOPUIUfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOPUIUfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015F01F000E9;
	Mon,  3 Aug 2026 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785759321;
	bh=8slqe05VD33waPBnQilZsaWx6TI48l4eo9pneGvh1dw=;
	h=From:Subject:Date:To:Cc;
	b=iOPUIUfopJmGLJ/3nXyqIKBxlp5uu9zRpFCHQvutI5ceZ164G0fYWwqErUqt9jd93
	 S1Gkvx/BWw58afYmLRdMjwIafuyGBcP6+A/NcPbntCtmLjM8IXFGHtUlqvQz85d+tG
	 kA00gk8tRzesYyjUPja/sZtL/qL2ycQlNbtKWH+SAJy2BC0N63zyUlOvbeYYZfQ1JF
	 dKxGYk9LOs6XUiBqm/G/qzR6pqV8lR3MwPvPZSNu/rKixKx0/A5lW/M/W2keLRHLYv
	 HgEHxdKYhxJ0zwFxjs8/wKK8+Ylg+Ou/beqoNMSr61n6H0CD4V4+XYH1Du6huZTPcw
	 B/4rI5ekbFf5Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] binfmt_misc: bound the interpreters an entry can
 pre-open
Date: Mon, 03 Aug 2026 14:14:59 +0200
Message-Id: <20260803-work-binfmt_misc-interplimit-v1-0-4a2435500bd9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOGcGoC/yWNUQ6CMBAFr0L22yW1JaJexRjTlkVWpZBuRRPC3
 S3yOZOXeTMIRSaBczFDpImFh5BhvyvAdzbcCbnJDFrpgzoqg58hPtFxaPt061k8ckgUxxf3nNC
 cNHlbNVRXGnJijNTy95+/XDeWt3uQT2tzXTgrhC7a4LtVTa1gXZpyO4Bl+QGtCoGBoQAAAA==
X-Change-ID: 20260803-work-binfmt_misc-interplimit-392eca4de742
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com, 
 mail@johnericson.me, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-f2f85
X-Developer-Signature: v=1; a=openpgp-sha256; l=2445; i=brauner@kernel.org;
 h=from:subject:message-id; bh=arBQ7R3qh9fuo1bIT/ltszB5Q9NNONeVHQeT13NTzno=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQVtIV52OTOWeD6TM+Cx/9uSoJ68YuUVzeish7Py4oRK
 vxXvfZoRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQeCzP8T/rx2u6Ee4Aw5ym9
 OUpvxG9VS88z0ju0+2S76KSNm6ovH2L4X1mnwfqg2rsokWn3vry47UeV3bl6bH4b9IWfkNj/MHk
 hBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

An 'F' entry opens its interpreter at registration and every exec runs a
clone of it. A 'B' entry does the same for each interpreter it binds. That
file stays open for as long as the entry lives. So it pins the file, its
inode, the mount it came from and that mount's superblock.

An entry binds at most 100 interpreters, but nothing caps the entries.
binfmt_misc is container mountable so all of this is reachable by
unprivileged users.

While the pins go away when the instance is unmounted, it's still weird
for an unprivileged namespace to be allowed to do this. And the fix is
simple.

Charge each binding to the user namespace and uid that makes it against
a new UCOUNT_BINFMT_MISC_INTERPRETERS and refuse with -ENOSPC when the
limit is hit.

A per-instance cap won't do. Instances are keyed on the user namespace, so
whatever constant I pick gets multiplied by however many namespaces the
caller cares to create. inc_ucount() charges the namespace and every one
of its ancestors, and a namespace can only ever raise its own limit, so
nesting buys nothing.

The knob is /proc/sys/user/max_binfmt_misc_interpreters, per namespace like
every other ucount. I left it at the max_threads/2 default that
fork_init() hands a new ucount type. Nothing anyone runs today comes
anywhere near that.

Selftests for all of it, including that a nested namespace can't buy
itself budget.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (3):
      binfmt_misc: correctly account pre-opened interpreters
      selftests/exec: test the pre-opened interpreter limit
      binfmt_misc: document the pre-opened interpreter limit

 Documentation/admin-guide/binfmt-misc.rst          |  12 +-
 fs/binfmt_misc.c                                   |  16 +-
 include/linux/binfmt_misc.h                        |   3 +
 include/linux/user_namespace.h                     |   3 +
 kernel/ucount.c                                    |   6 +
 tools/testing/selftests/exec/.gitignore            |   1 +
 tools/testing/selftests/exec/Makefile              |   6 +
 tools/testing/selftests/exec/binfmt_misc_bpf.c     |  70 +++++++
 .../selftests/exec/binfmt_misc_interplimit.c       | 232 +++++++++++++++++++++
 9 files changed, 343 insertions(+), 6 deletions(-)
---
base-commit: 7693ae84747b6e72a1a3d14b836f7bec11606e08
change-id: 20260803-work-binfmt_misc-interplimit-392eca4de742

