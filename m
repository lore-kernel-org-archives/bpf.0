Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911674;
	b=5pjYE3fFAlSyz8cpa9VEqgjXPTUDXxBlTc/YyKG0z0TZaUewzh55H+fy4ihoGucswCBm
	 i/zBsXqJcYJ7uzV+JEiu4QVXehKMGe6JZrE7ijnkwWxuJPnBs/CqUQqNpqKnzBfRqx7/p
	 f+AcvzhVwx4CvtSMahUT/c0pZWFrzLIwi3IqeorerCO+wEXjf/o9RVd9jXu+HPfdpV40p
	 eE97kFQ72lrANSvDOo5cE9myo+u87cJvGOVuYH70uu2S91621O04Y7PLHku8DLTnX4FLQ
	 kU89vHwgYMIz30p5Yw281v6/T4XOTGAJqeXCMN+B5WmjVEc5rwm5TRIUOSt1tj6dXvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5og5gbIFuLrK4odCnF2cFU+0oOHDzasvRkpi1DDbr2I=;
	b=2oQvUp6ZnEsojPIsJC/17CkP8KFXePugK9HiYQnTA2pGq8et5z2sKH9QSr8pGxJRSBzW
	 yoKu1OxbQ3Rumj0E0dAIpBeJTuPy9BOfLWVX0gXAwdxyPrz9y96ql9xmRqEIjlw09Cnjq
	 QkRA1cBe2vY0UvKcxVNtEsxKlstS368NCKfpZMW7/djR1+vsGM079wHb1o1OrABj+9x8X
	 pcXid8u1T3Ub/ooaBiUkz0aOhhdlwv7FpCYI8yk6Offn66GE6RF2k5Nc3+Hp93Lfuya7h
	 0BNWvsGaSIYzQ+Z30/mhn13kt2qOJjUPKP1Ve7LVjc+KMlmp40W5AWgwaj1BqwgPImA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=nHjFWE76;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD460A2604;
	Tue, 17 Nov 2026 10:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57BD460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=nHjFWE76
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW8-001QXp-Fe; Tue, 17 Nov 2026 11:34:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=5og5gbIFuLrK4odCnF2cFU+0oOHDzasvRkpi1DDbr2I=; b=nHjFWE76JFPXgbBj/GeNNNvAxS
	rCElX7eBJuvMRBI2r0YgBwqdDHlcd9GW9k6/LLuvu1OwgHhlKoU+l9rRWm7yCBshvzmWvvIBlKlM0
	K8xGP8ToMETKCwq2SXPoUKChDlUHLJee29V7kuvfrFa+7/Hs+PER1gEfjMElwidyVTVbIicZuU3+f
	JiEMt+qiIQG53/dQMi4dPdRmxdGgEGjKnnahjPpF5M2d4qbMnV4yIeJoSso0Licvv25SFUtQL1flb
	FYSnK7T/LwGjdizJeVxdFJUPpYsqIudunBFDBEgC8OMl+iRCIieKjYXAzipEgqUo7mGsXW8u8WLeP
	ddpPFdMA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW3-0002FD-2J; Tue, 17 Nov 2026 11:34:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVk-005qHU-1t;
	Tue, 17 Nov 2026 11:34:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Samuel Wu <wusamuel@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 next 01/13] scripts/kallsyms: Avoid overrunning on-stack buffer
Date: Tue, 17 Nov 2026 10:33:40 +0000
Message-Id: <20261117103352.1244657-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117103352.1244657-1-david.laight.linux@gmail.com>
References: <20261117103352.1244657-1-david.laight.linux@gmail.com>
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

A maximum length symbol can be KSYM_NAME_LEN long (including the '\0').
But the name being compressed contains a leading symbol type (e.g. T).
So when the compressed name is expanded (after the hex is written out)
the buffer needs to be KSYM_NAME_LEN+1 bytes long to allow to both the
symbol type and the '\0'.
But it is declared 'char buf[KSYM_NAME_LEN] so a maximal length name
overwrites something on stack.

Found by code inspection, seems to have been broken before the code
was imported into git.

I expect there aren't any maximal length symbols and/or the byte that
is overwritten is something that is either zero or 'don't care'.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Unchanged from v2.

 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index ecb444078c1c..140e888bf713 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -398,7 +398,7 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 	unsigned int best_idx[256];
 	unsigned int *markers, markers_cnt;
 	long bin_start;
-	char buf[KSYM_NAME_LEN];
+	char buf[1 + KSYM_NAME_LEN];
 
 	printf("\t.section .rodata, \"a\"\n");
 
-- 
2.39.5

