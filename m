Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792632905;
	b=cS7xKunhvwzL3j4p/hOkQhCRyIp/I/Vf10rLOHyalqqwsqEKw/5K9fUqwhbdhB92hRVR
	 3uh7b7RZyCs5oj9Y93gLtHKaZeMht+z9yosS88fsNnimwY+iPp5FPGU8efU54ZWfVKx2P
	 b78DMMlEtCNNOZBUz7KAW2JkxuLyfnuJ0AQfSx6P3+d99tlbWhbY9hHB5qgomrZlQEM2e
	 NNDiFtzQrVDytyzH7/CoMngpjQsxjV6KDF0ZRkhXnXzW3QIGPFZKTsbmgLVYpfuy8KMNJ
	 AxUqDfIkIvjTpKutkrPc2PdUhGPrAx2KEDsIilviTUbJ/QWw/+gnYr4vPlZAh1bapuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632905;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l6gT621i0UWoUJpKXQafhWyEypuwooQXgCBqVfVlgR8=;
	b=cqthYQf7OlzOELXySRwD9tv0KSH2Kdtd3I5cwpOUqFKDzi2sndMNoKpH2cJfrQicROwb
	 MccJ7qO2mqrKCyhW/fhCTI+Kp7MG7QAqLj3f7uIc932br9gAwBm+O1LjITIiYL69+QzPj
	 NvF9/94uD1jD74alotLxJQQhCdhPnXvzbsbYPvS719b/JQKntIyLFrgXdNH4M4m2asl0V
	 D9Djd77xnAf9rk7UFPWnJgmr6VTHMN5LmNr2qg4Gs9jkXnyh5eGHL90fvAOGSV3TsBybs
	 x/m3RbQGPczYS+0pQoecd+HC/CFmizSd+Cw5IIixoAsce+XQBwFOrKRMIsdnldMJ+jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=skyn3tlab.com;
	spf=pass smtp.mailfrom=fe-bounces.skyn3tlab.com;
	dkim=pass header.d=skyn3tlab.com header.i=@skyn3tlab.com header.a=rsa-sha256 header.s=fe-ef0e585ad0 header.b=33VvVVXH;
	arc=none smtp.remote-ip=121.127.44.66
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD8606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05DD8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skyn3tlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.skyn3tlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=skyn3tlab.com header.i=@skyn3tlab.com header.a=rsa-sha256 header.s=fe-ef0e585ad0 header.b=33VvVVXH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyn3tlab.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-ef0e585ad0; t=1792632898;
 bh=l6gT621i0UWoUJpKXQafhWyEypuwooQXgCBqVfVlgR8=;
 b=33VvVVXHhEMcos1Q598XioV/W5r0t0hlfRgVdrtgq/HS6ecsWxS+kf8RZU/EUKOJqsUaVVP+7
 54Rm9NbRk2qC0zlG23qbtSUY2iadtI2gd0CNGOKAsnMnjm8dYL8R7aCyswvePUKUTNb1oU2lSTk
 TtXWXewP0R08Qz9252ME1Fs=
X-Forward-Email-ID: 6ad9682a68c864fa427ee3d8
X-Forward-Email-Sender: rfc822; gr3yf0x87@skyn3tlab.com,
 smtp.forwardemail.net, 121.127.44.66
X-Forward-Email-Version: 2.18.9
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Mark Severson <gr3yf0x87@skyn3tlab.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: changes.rst: set the pahole minimum back to 1.22
Date: Wed, 21 Oct 2026 21:34:32 -0400
Message-ID: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF
annotation emission") removed the paragraph saying that kfuncs annotated
with KF_IMPLICIT_ARGS need pahole v1.26, because resolve_btfids now
emits the kfunc BTF annotations that pahole used to produce. That
paragraph was the reason the requirements table lists pahole 1.26, and
the table was left unchanged. The text below the table and
lib/Kconfig.debug (DEBUG_INFO_BTF depends on PAHOLE_VERSION >= 122)
both still say 1.22.

Set the table back to 1.22, in the English document and in the Italian
translation, which carries the same table.

Checked by building linux-next 20261021 with pahole v1.25 and
CONFIG_DEBUG_INFO_BTF=y: in the vmlinux BTF,
bpf_task_work_schedule_signal has four arguments and the bpf_kfunc decl
tag, and bpf_task_work_schedule_signal_impl keeps the
struct bpf_prog_aux * argument, as Documentation/bpf/kfuncs.rst
describes for KF_IMPLICIT_ARGS.

Fixes: fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF annotation emission")
Assisted-by: Claude
Signed-off-by: Mark Severson <gr3yf0x87@skyn3tlab.com>
---
checkpatch reports the Assisted-by tag as non-standard; it follows the
Attribution section of Documentation/process/coding-assistants.rst as
published on docs.kernel.org. Not run: make htmldocs; the change keeps
the table's column widths.

 Documentation/process/changes.rst                    | 2 +-
 Documentation/translations/it_IT/process/changes.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 28f2ca633..13093c5c2 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -53,7 +53,7 @@ mcelog                 0.6              mcelog --version
 mkimage (optional)     2017.01          mkimage --version
 nfs-utils              1.0.5            showmount --version
 openssl & libcrypto    1.0.0            openssl version
-pahole                 1.26             pahole --version
+pahole                 1.22             pahole --version
 pcmciautils            004              pccardctl -V
 pigz (optional)        2.4              pigz --version
 PPP                    2.4.0            pppd --version
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 0be1292a8..5adeee24c 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -57,7 +57,7 @@ mcelog                 0.6              mcelog --version
 mkimage (opzionale)    2017.01          mkimage --version
 nfs-utils              1.0.5            showmount --version
 openssl & libcrypto    1.0.0            openssl version
-pahole                 1.26             pahole --version
+pahole                 1.22             pahole --version
 pcmciautils            004              pccardctl -V
 PPP                    2.4.0            pppd --version
 procps                 3.2.0            ps --version
-- 
2.43.0

