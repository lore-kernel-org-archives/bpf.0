Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DB36654C;
	Fri, 16 Oct 2026 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121080; cv=none; b=d6CkmnDsGuQd+/0qP0R8AnOYlQjbbRW4PRTW8jNvIn9CAm8HjxY/bnFoX2KmQwKSSnd4ThWDlaPNd4RiQI4Tw0d/h2ww2XV0LjYQMZrL0XHaTFXtyQRORMMDiIIhdFUA2d1H0HsBp3AdraTuYo0Ia9RaQZ3XY8U5l9jhM2hf2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121080; c=relaxed/simple;
	bh=za1eFwAEu8jQBGOlG+dM5HJ+tXBbzukHM9C180iZ0X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsNUpLtcqSL2pVXoFb0eq5Y9+9SNCTgw9E8hGTxpe1bch9x/WgLhTBgA2cMlg2PkzWhX1K3vz9QsVohI+/dc6r/jYaxtAPZphq5xbXVHdP2hjBosLp2e+2dq0NjYxbT04w5vk2D7+1HKh9L6ah6H2Ww+FuxYZgR1BkapcVP43+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=G+xTRlde; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="G+xTRlde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=G+xTRldezzJmgm59AXt7Oey/EbKvXYKjKFKaeRITacmxK+j826rr3IwyTMJwhB0OeHODv83bYqzdU
	 ew/W9fp24J8xjsNW/aMWS0VDhI60AsRcDqrNdQm7uqAzhX2LWBTOSf9Czgx8/RpRTjejTnFFh0obsG
	 fNTYon2kNhWv6/ew=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ad198edc12-c64b9;
	Fri, 16 Oct 2026 11:24:30 +0800 (CST)
X-RM-TRANSID:2ee66ad198edc12-c64b9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ad198ed8f7-20ae7;
	Fri, 16 Oct 2026 11:24:30 +0800 (CST)
X-RM-TRANSID:2ee56ad198ed8f7-20ae7
From: yanxia <yanxia@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix packet length loads into X in bpf_dbg
Date: Thu, 15 Oct 2026 21:57:02 +0800
Message-ID: <20261015135702.352284-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_single_step() handles BPF_LDX | BPF_W | BPF_LEN by assigning the
packet length to A instead of X. This leaves X unchanged and clobbers A,
so bpf_dbg can report the opposite verdict from the kernel for a valid
classic BPF filter.

For example, load the following filter and run it on a nonempty pcap:

  load bpf 3,0 0 0 0,129 0 0 0,22 0 0 0

The filter initializes A to zero, loads the packet length into X and
returns A. The kernel rejects the packet, but bpf_dbg reports it as
passing because the length load overwrites A.

Write the length to X, as required by the instruction, preserving A.

The issue was found by reviewing the load cases in bpf_single_step()
and comparing them with bpf_convert_filter(). Tested the complete
bpf_dbg executable before and after the fix with GCC 12.3.1 on x86-64
Linux 6.6. The fixed tool agrees with SO_ATTACH_FILTER on 21 cases
covering X updates, preservation of A, and LD LEN, LDX IMM and LDX MEM
controls, including a truncated capture with a larger original length.
The original tool disagrees on 12 cases; the nine controls pass with
both versions.

Fixes: fd981e3c321a ("filter: bpf_dbg: add minimal bpf debugger")
Signed-off-by: yanxia <yanxia@cmss.chinamobile.com>
---
 tools/bpf/bpf_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 00e560a..51af4c2 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -713,7 +713,7 @@ static void bpf_single_step(struct bpf_regs *r, struct sock_filter *f,
 		r->A = pkt_len;
 		break;
 	case BPF_LDX_W | BPF_LEN:
-		r->A = pkt_len;
+		r->X = pkt_len;
 		break;
 	case BPF_LD | BPF_IMM:
 		r->A = K;

base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc


