Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398392;
	b=VBtOxQNLGtN4kOwR8JZMqXLgKD0zLtyMH66Ig3z/kCOx9Kf9t00ehNLdmGy/d56c1fdN
	 f6/nWqI7WtNnRJKfamhsD6BVuvbCXPK87Ap9/l4jQELroiUhddHPZVwy3atdUqXCZyekU
	 zQyWo9kOUGQErXDncHJqYfQ6F3UgQTFMLo8suGVtQ+nZdNGWT3sV8GWa2KeXkV8D66elW
	 FvgP+Whcdezog6IS5diFW5A8L9G1koAbt3pAU0XdvCZEj0f5KlmVkOh3mizmnKyV7KvsU
	 7uEAr9igQm2XKT/MLG0Ak2LwXS1uhxLkRt3YN5M0h7XQcv7I3aoj5p/5p486Iep6/oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5og5gbIFuLrK4odCnF2cFU+0oOHDzasvRkpi1DDbr2I=;
	b=cLdCmvNp5mE6tMGUgSMLF09lNJ+/gPsvF7R/bI3IDnF1ebOlrdoj1nenvJgsbmhgDCk9
	 lmwkrSGgk4o3gxxlQ/DQ0Gl1MIISPgwLYSH0cJAT7jiVRALw0E8E27gBP+qfO+uvM8I88
	 HRMu3hBNWEASz9DsRNnv4iJ/K/PCWWsBcu91xtIqdxT+J1odNtS5PYdCcM2xjAHUhjNhU
	 G1A1butx57lAj08bJmZiU7clfPaLZ5JtkvZ4VAkSwdrqvZLSo5iosYyrJ4oNIUN/ZMtZl
	 bEXimbEiQVLKgHplUgoIH8p0jZ9d2IXy/cEePgbtE5KXnUfRmGdAxayATbU7jm/IVMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=ChTyJA5y;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55B60A260C;
	Wed, 11 Nov 2026 11:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD55B60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=ChTyJA5y
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zL-001rxD-RG; Wed, 11 Nov 2026 12:59:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=5og5gbIFuLrK4odCnF2cFU+0oOHDzasvRkpi1DDbr2I=; b=ChTyJA5y5+wuBM2O7bdH+tpas9
	ql9IyalmR6cW5KkL5zGyIkVjpzJh6xlaP8WS8zOFkDEAyruBNFTacGUVvz8EhWxzsmvaWtGv+U2XM
	peC0m4URPYOpy48YtVJW0/Bh95szz9AmL3ASsVIMiFLyZx08Zbbwoh9Mb4YH4y3V6vDXQ4wkNMtm3
	hNKE6efIs+Vt91s0L1EJCMsQ3nXGwprGl0o/VxypEORoCCw0BPJtFGHN4xTEmajZD1XU8HqqT5TDa
	PZKQ4mRzfEoBSLt3SIJBmIV1oEwDRJd3g9SMKbUSJPnVqjnqhw4KlX1sTFX9aRzKZ6zrrXaoyYTW7
	7f8/7dSQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zG-0000Uf-8m; Wed, 11 Nov 2026 12:59:34 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6z4-001mRM-MH;
	Wed, 11 Nov 2026 12:59:22 +0100
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
Subject: [PATCH v3 next 01/13] scripts/kallsyms: Avoid overrunning on-stack buffer
Date: Wed, 11 Nov 2026 11:58:59 +0000
Message-Id: <20261111115911.1142000-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111115911.1142000-1-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
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

