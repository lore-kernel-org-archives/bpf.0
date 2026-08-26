Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AE416878;
	Wed, 26 Aug 2026 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759760; cv=none; b=mcee/SpjfGonQrDoB8pWnJOh0tR0vqO9vlAdtSwgNGAj0RzJ71CJs++BdGZFV3IWVlRYbpnp9r1gcO2rb5j9KWSNQOKVS+zK1B/QX6wA5sVO38NVQ7a+JCwgWu0i2qJZyEyHD3f1UzvZmJHCpllZl1NeNUS6oDUO+oDex6twqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759760; c=relaxed/simple;
	bh=Phb72AoqbVHIC31C23WEo20gDWkMp0/dpMPIljHQDwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A4bdJxmLGwBmTAiM6r7XUN3ZFxEQ4mcGdd5bC9PTkxKa1YGRkzPQe1+NpdYH7doQkMrFsxhLxhjHXaNWcqw9nBR1KPNViRwaWLrH6m18ppCi6k17bOS7UUcHb9Ft4JTEoD1ia3t/tb+BrucfTfy0d2FRzLdrmbodkhaHhYvlNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB7f7OhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB7f7OhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD141F00A3E;
	Wed, 26 Aug 2026 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787759758;
	bh=BwOwlrsMKFa+viIlDHPfEgFRdNQZleimxjv4DOddYv8=;
	h=From:Subject:Date:To:Cc;
	b=UB7f7OhWq1DxpKTgfVroj21MHn7Asx3BUizcAKwgMLDZI89Ej0SK4pvtDO+QrYvBq
	 LUpuQp7ZGpyjzVXCp2OVa4TTmYXwP6+QGEBMkRdWcUT3UUviOFeQ++kU8MwDuj+MpU
	 xk4iMSPnBlscuNkNry6+AtEEAL/JBFT2ENYY7sk5LnTXPOSdCKMwBGZT4iqhscLdbw
	 qMcnDIXZpulbTFQIbJ9XMIp5nDa3BEvWTFh/NOoyR5Mf13Amwb0ymTEm/XQYAQeItP
	 3DeakQqDplWN6tcYhTP36A3jhIKTIcU2rhwSrs2lSPslf0aIiSHgh0Fec8e1aXhmDe
	 4s9bQvFqRFFwA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] binfmt_misc: only let punctuation delimit a register
 string
Date: Wed, 26 Aug 2026 17:55:45 +0200
Message-Id: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03M0QrCMAyF4VcZuTal62AMX0VE2i51UddJs6kw9
 u6288bLP5x8KwglJoFjtUKiFwtPMUd9qMAPNl4Juc8NRptWd7XG95Tu6DiGcb6MLB57evCIXRN
 a450PZBrIz89EgT87fDr/WhZ3Iz8XrSycFUKXbPRDORVX/blqd1VZwbZ9AfjKkpGoAAAA
X-Change-ID: 20260810-work-binfmt_misc-delim-83f62cbcfe23
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Phb72AoqbVHIC31C23WEo20gDWkMp0/dpMPIljHQDwM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT183Qz3+6pPNDT/i0r7sXcF57JC4O2usbrec2s+HdOz
 8dlQt3CjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYX2dkeOHV7qt0W9bnfazv
 rh2nMjKV76gViE2MzLH3cK+6+Uarn5Fh8caLLOWfL3MtXaPKqF/f/TL7zOnJO8WnL8v9wHniVuw
 EDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently we accept arbitrary delimiters which really makes no sense and
from looking around it's an unused feature. Everytime we add a flag the
number of possible delimiter shrinks and it makes extensions much more
hazardous than they need to be. Stop it and only accept punctional as
delimiters.

This extends commit 8e85d50ba111 ("binfmt_misc: reject a flag character
as the field delimiter").

Letters, digits, whitespace, control characters, bytes above 0x7f and
the backslash now get -EINVAL. Everything deployed uses ':' anyway.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (3):
      binfmt_misc: only let punctuation delimit a register string
      selftests/exec: test delimiter restrictions
      binfmt_misc: document the field delimiter

 Documentation/admin-guide/binfmt-misc.rst        |   3 +
 fs/binfmt_misc.c                                 |  12 ++-
 tools/testing/selftests/exec/Makefile            |   4 +
 tools/testing/selftests/exec/binfmt_misc_delim.c | 127 +++++++++++++++++++++++
 4 files changed, 143 insertions(+), 3 deletions(-)
---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260810-work-binfmt_misc-delim-83f62cbcfe23

