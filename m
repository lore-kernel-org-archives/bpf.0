Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633701;
	b=AZNvd9fR782gBR1c5mBIVkiyW0FFcbmA/ECKe9mUracAd/xG3TW1X0MhMPI7wvQCNegd
	 3o9IAsVnEEvQKOM/LTCaOaiVb+/3jkTYu6wSLMzt6GQwqB9ZQCSY4K6pPctNIrrRLK+6V
	 sJG/jWUb9QZVWEUOlZEQWp4/xptpXbT+g7kdlwBO2nt6suqk46h9RQCQWRdZ1gkyX7PfL
	 EQTUozHm50bu4mpxwy6cX43hDE9VqZ2h7TSbr++zEEGxmtNrGdnBtLwvue+yoKFNY0PwF
	 Olw/iW8ddBLMaNenL4GdVnKodbYKTw2gE4dZrPCPVb+YoZhekiSyZTUOkj+1UJhMALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633701;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LW0K1y3Aru8asUab0ZoHmJkJJzy67mmJNwo7if4GdpQ=;
	b=qsvgkLaXviJcNnnEOcdAgF1ARVHg7EQG918IxZW8HLpBZlV4Nj34/p5Xfy2/bYs+s0ml
	 JETsW7YfjrXCeqMSMSb6xJgvBWfUT9soHwJ7owjnictyJLgglpILcn4cLyE1drpQFT4n7
	 hlV+fLfHm5kEDfsfZLYXuJpVSTPMhE7IUiJpZT/aNRdJyE4kz4OcrfEai73UEVR/Qh4L9
	 ae4CGR7MfhHzHBCMBIGX5sQW3a8CFoNatl/4/9ynNqqC+RUS2KpCYi+Kul4++5SgXNTop
	 MobInup/dQD3iaIq/SwvFyC8aGQx9GfM1KmAkcFxIcAxM2ji2LUmZ30zLIBIdDyG5lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=skyn3tlab.com;
	spf=pass smtp.mailfrom=fe-bounces.skyn3tlab.com;
	dkim=pass header.d=skyn3tlab.com header.i=@skyn3tlab.com header.a=rsa-sha256 header.s=fe-ef0e585ad0 header.b=7qH8gXmA;
	arc=none smtp.remote-ip=121.127.44.73
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11270606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11270606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skyn3tlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.skyn3tlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=skyn3tlab.com header.i=@skyn3tlab.com header.a=rsa-sha256 header.s=fe-ef0e585ad0 header.b=7qH8gXmA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyn3tlab.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=fe-ef0e585ad0; t=1792633694;
 bh=LW0K1y3Aru8asUab0ZoHmJkJJzy67mmJNwo7if4GdpQ=;
 b=7qH8gXmAz3OVXnfk/hQIziwQDU+o9HmfBYfTmXqY6L+ef47uOrQq/XEQ9JrRxL91OkS1uPPtd
 QkEyqMbUzcaKkOn3qRZnXdJ/e7OEIPMmAtzuAXSI8paKxmGJvgPMawqWTa68LJg3iWbQTiR4I6y
 PwiA5+ylUBTDRqGSI9zooN4=
X-Forward-Email-ID: 6ad96b5cf76a2e0ef8b0ba48
X-Forward-Email-Sender: rfc822; gr3yf0x87@skyn3tlab.com,
 smtp.forwardemail.net, 121.127.44.73
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
Subject: [PATCH v2] docs: changes.rst: set the pahole minimum back to 1.22
Date: Wed, 21 Oct 2026 21:48:11 -0400
Message-ID: <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com>
References: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
translation, which carries the same table, and remove the Italian
translation's copy of the paragraph that the English document no longer
has.

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
v2:
- Also remove the Italian translation's copy of the KF_IMPLICIT_ARGS /
  pahole 1.26 paragraph, which fd5425b67355 removed from the English
  document only; v1 left the Italian text contradicting its own table.
  Found by the Sashiko review of v1.
v1: https://lore.kernel.org/all/20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com/

checkpatch reports the Assisted-by tag as non-standard; it follows the
Attribution section of Documentation/process/coding-assistants.rst as
published on docs.kernel.org. Not run: make htmldocs; the change keeps
the table's column widths and removes a whole paragraph.

 Documentation/process/changes.rst                    | 2 +-
 Documentation/translations/it_IT/process/changes.rst | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

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
index 0be1292a8..b4accd428 100644
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
@@ -149,12 +149,6 @@ Dalla versione 5.2, quando viene impostato CONFIG_DEBUG_INFO_BTF, il sistema di
 compilazione genera BTF (BPF Type Format) a partire da DWARF per vmlinux. Più
 tardi anche per i moduli. Questo richiede pahole v1.22 o successivo.
 
-Dalla versione 7.0, le kfunc annotate con KF_IMPLICIT_ARGS richiedono pahole
-v1.26 o successivo. Senza questa versione, tali kfunc avranno prototipi BTF
-errati in vmlinux, causando il fallimento del caricamento dei programmi BPF con
-l'errore "func_proto incompatible with vmlinux". Molte kfunc in sched_ext sono
-interessate da questo problema.
-
 A seconda della distribuzione, lo si può trovare nei pacchetti 'dwarves' o
 'pahole'. Oppure lo si può trovare qui: https://fedorapeople.org/~acme/dwarves/.
 
-- 
2.43.0

