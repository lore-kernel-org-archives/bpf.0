Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386273;
	b=xVB3vrrh+rzJAe9SdzVHLlwWkfarZCGdbAt0DMuwUFHmcDj69KcfKlXdBGRi9ak/Lxf1
	 eVg1t5kb6l7LY31nTGoSb8U+Pb4LCChxxUmZSeds7D7HKrqqBUUyHiv9L/5f4CHcPfEe1
	 WhEemSe4yyN1GaLtv7C6kGpcECcySw35vmRPDaCW1DAPPxBOSD7rLhd1C8UTChCdd72Gx
	 fkhK9ynNKBq2vnzSDMCF4gGHrSaSJKKwG9CuACHeluholnrnN+HGKkbtFpmKDpKQeohGq
	 A7Sn+4AJ7CkCDz8M4d8Txgn8O0p23vYEIxpsuV/eABP4x5sGMMRTz9q/oyq+lrJEcfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386273;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=0QfhBYw8VeOIYuvlcIqwp+Enfo+SxDpyqV9uKzvrhz8=;
	b=b6jOIHTENOH3PCgII4FRXvHURm9MHAdroEnP3U38os15/HkVc86cxjQKw7GnrsgY2Iy0
	 4gKL5rIt75KU+D8DatzgZUAlQdk6sj53b03ibYGxySWyZlaqdFQQIZ0YHjJefd5HbPY3+
	 13wQl9l60FHerQNLQ3yEGPnTj71P0zWPtKEfY2uw9PjOWt+f7D26xF9TPCt2XJMKKH3pI
	 /JmDFSBvmEip++PZa4tis6Ik6UL02YDiyxwGeYeRrPgd7+DplDPHcbi7JK4nDwXV6Tu6j
	 T8TXtDAqtotxXkccKWVlhx7XRR4OgQwciSj5/COGs7pgET+NV8f3hMZ4PussTVmAzNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WtK0EAhl;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87550606A31C;
	Fri, 30 Oct 2026 18:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87550606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WtK0EAhl
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D39881A13D4;
	Fri, 30 Oct 2026 18:51:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91306603C2;
	Fri, 30 Oct 2026 18:51:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAB96103287DA;
	Fri, 30 Oct 2026 19:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793386263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=0QfhBYw8VeOIYuvlcIqwp+Enfo+SxDpyqV9uKzvrhz8=;
	b=WtK0EAhl5HEzZAsN55XKY88FNSr0p6pKww1AN6kmzVBVyy16eIov/agU1lep9G7bGUkPyg
	tvNL6TIyV+eta+5Tb4D+FB8fguBKTDsDu8XZUpAGTwIj0ymLSm9bJkPAYdcHCNNJuFBv+x
	PXR7Q0rUsBP00e0rKprgxzR9uALqVt4c8C7jj526BRkAGtEQya9zrpp4Mbnc9eD8sWwUR4
	Ce7Z8afgQ2ZsgsFp4pbvQpSXtsa2L0ZEA1zB9W5Rhu+g2fMb1Tn4iBTqbAZ/GPjGfcgpL9
	b5hMeKdzC2D5wn7nJPVKn75WyXJFrrgfEG8t8lwurLHPQViHds+QdJrrdpuzng==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: port test_ftrace.sh into
 test_progs
Date: Fri, 30 Oct 2026 19:50:39 +0100
Message-Id: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBAAvyJ7biBGqtCvlBJi3Oh6iGF3WwTx7
 03rcRhmDhBkQoFHcwDjh4S2XKG9NRCXkGc0NFUGZ13fWjeYpBwiespeUdQX3mYx0z0NNriusyF
 CTQtjov2/fcJYksm4K7wuI+9xxai/K5znFw7uYVyCAAAA
X-Change-ID: 20261027-ftrace_in_test_progs-d5f70a2330ac
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this small series aims to port the test_ftrace.sh script (testing that
trampolines and function graph behave correctly when both are enabled)
into the test_progs framework

- commit 1 brings a few new helpers to manipulate ftrace from test_progs
- commit 2 performs the actual porting

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: add helpers to manipulate ftrace
      selftests/bpf: port test_ftrace.sh to test_progs

 .../selftests/bpf/prog_tests/fgraph_trampoline.c   | 129 +++++++++++
 .../selftests/bpf/progs/fgraph_trampoline.c        |  29 +++
 tools/testing/selftests/bpf/test_ftrace.sh         |  44 ----
 tools/testing/selftests/bpf/trace_helpers.c        | 247 ++++++++++++++++++++-
 tools/testing/selftests/bpf/trace_helpers.h        |   9 +
 5 files changed, 412 insertions(+), 46 deletions(-)
---
base-commit: 960cc441448b063bbc1f283d7e801af6d872e45c
change-id: 20261027-ftrace_in_test_progs-d5f70a2330ac

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

