Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6A37B407
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143949; cv=none; b=QXibZY6/3It/teZYQL6s5DEndp8Dw9P++jPxNUKPlU7FO7wzRe2p/AXp4R1FL6j9zEGfKnSYhiyiPpzkIfIx4DOmT5aEy8gdIea5+hTzsIvhQyj4wXVWRyNRm39EXRdtWL3xvLtgFA8Kvh+IVramFYF2kYeGrbRa5eC1KQFYato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143949; c=relaxed/simple;
	bh=hB7HnwUK3/ELtqDqgPJBn1gu4lTECYsJwrNfv2JnJkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYGz4Dt0/XWJDgLNfnD8iPFnf8lktjpO1giBI9DDMVJ3UBtlKws7dnn8+KRSLCK0B/jhIfEG2zKlUIiQD2/b7GBVTiuG2iPRMuQ8cenQdEzVPtaULPZ8M3y/VZs0GtuhpPZeOxlTddnERjzUE6IG4+B4K30iXn8ZtBRbcVQZMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gq53H2/7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gq53H2/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXTsiAuJ0Ml5eEoT2v3CB8gGptbXj7qArGf4X4fCTX0=;
	b=Gq53H2/79u7mRYte/br+QMpmLl8PKDXCfJH+MZ/S5WtYhGDZzr10o42Qmlv5xx3+A3VWt4
	c4dxgdWuDp3mU5PcWBsTeg8K/aTRUNTYYeVmtbar8O/mkdIc5h4H74w3xEuv0wp6fl2C43
	rvDHE8nI93eGA83Kjhi/qsEzfuSgclU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-NyNUN4QhNkmZBjcJYupS-w-1; Sat,
 21 Mar 2026 21:45:44 -0400
X-MC-Unique: NyNUN4QhNkmZBjcJYupS-w-1
X-Mimecast-MFC-AGG-ID: NyNUN4QhNkmZBjcJYupS-w_1774143942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1281B18005B3;
	Sun, 22 Mar 2026 01:45:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94A1C300019F;
	Sun, 22 Mar 2026 01:45:30 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv7 05/13] kexec_file: Implement copy method for parser
Date: Sun, 22 Mar 2026 09:43:54 +0800
Message-ID: <20260322014402.8815-6-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Copying the bpf code parsing result to the proper place:
image->kernel_buf, initrd_buf, cmdline_buf.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/kexec_bpf_loader.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index c79fb777d51bf..af16f7b685d9a 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -78,6 +78,7 @@ late_initcall(kexec_bpf_prog_run_init);
 #define KEXEC_BPF_CMD_INVALID		0x0
 #define KEXEC_BPF_CMD_DONE		0x1
 #define KEXEC_BPF_CMD_DECOMPRESS	0x2
+#define KEXEC_BPF_CMD_COPY		0x3
 
 #define KEXEC_BPF_SUBCMD_INVALID	0x0
 #define KEXEC_BPF_SUBCMD_KERNEL		0x1
@@ -307,6 +308,34 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
 			}
 		}
 		break;
+	case KEXEC_BPF_CMD_COPY:
+		p = __vmalloc(cmd->payload_len, GFP_KERNEL | __GFP_ACCOUNT);
+		if (!p)
+			return -ENOMEM;
+		memcpy(p, buf, cmd->payload_len);
+		switch (cmd->subcmd) {
+		case KEXEC_BPF_SUBCMD_KERNEL:
+			vfree(ctx->kernel);
+			ctx->kernel = p;
+			ctx->kernel_sz = cmd->payload_len;
+			break;
+		/* Todo: allow the concatenation of multiple initrd */
+		case KEXEC_BPF_SUBCMD_INITRD:
+			vfree(ctx->initrd);
+			ctx->initrd = p;
+			ctx->initrd_sz = cmd->payload_len;
+			break;
+		/* Todo: allow the concatenation of multiple cmdline */
+		case KEXEC_BPF_SUBCMD_CMDLINE:
+			vfree(ctx->cmdline);
+			ctx->cmdline = p;
+			ctx->cmdline_sz = cmd->payload_len;
+			break;
+		default:
+			vfree(p);
+			break;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.49.0

