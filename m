Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659770;
	b=22bCYL6ODBJ3E6cLtmJhDcRqUPLpv7N0FK2NGhuIjvVYrQzPfsvBAoZrENiYAp/X2Jkb
	 0MkN4WiaGIsNxAGb+GwBNUXLXEqOxBtw/mwyQVDGqKphCBVwwZMon1pB3KbtKXkM2wPBf
	 G6h1j/EAEibeyOo1maL3Ry5oSE4TEcsXZdEmUMFIblYTLFkG5BUw92LaSQUJIsd0UYAvM
	 jYgsRAY5rJX4QeyTIF8JhnF18T1SFWDXKzKaBliX1ArC3UxFf0daARz56Z5lI+a9gX3oD
	 1nUPG84drL8rD48u1cSvHu4bhiU0gR7pHzLs44ajb5MPEpmU2FhMbxneT4kuPMF1rCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xPVIOrJME2+FRmlVa4Ph+81dFFJXHKxCy7RK0PFxH3U=;
	b=Wm1sqEhOZN/uDTnRVANGc/aUI2wUJGrIXcAlwrQYnZmZgIbkMHDXaBvENYR4KbqV0mXH
	 GE1EEHBn6rt5cX1gT6a1O0m0XzrNkHzcGnWXdnUTGohG8JlvTutWcdJwRp7bsmjUMTf5z
	 Ua8TcywBrUVlAnCMzu1+a0drorP9vQstdYiS3ZWR/keo+8ubl6gw0YvY2TTIQwvNhphPu
	 Y5YmMkYoMTNrYs/eMrrWRYoo99GDxToFQSyXdboMcFtmNkt3qVMr0oftjo7nNZIIZ8itU
	 nA63kVnoR2pdMQ/8HBnYWIK+PPwcVee956anT1Gd5EHJ+IQQCbaiIJ4H80YT6wDPnWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVfnC7Sb;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA5606A32E
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62DA5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVfnC7Sb
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1368625a12.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659770; x=1794264570; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xPVIOrJME2+FRmlVa4Ph+81dFFJXHKxCy7RK0PFxH3U=;
        b=ZVfnC7Sb4eNB8b65r2Hc2izQ+1dDwA0kPYADjv5ttcWGWLqrvarH0Ymb/PlTJf74fE
         Tz4jCUP8Enu5fId0TgsCN0U0VdOgrk+9gX0nprDvgY0y5Ms61VebCt3oh+i2yjv4qy9n
         XhpjrMz8VKeruwhJyCGjrSLisgFLdkRNleLHoDlEVHmyxegqVkQb3VAo16C722Zf4C5O
         scIq4uv5FaL34ODyjof1rZF4+uZGJxNOfdpfGB/2II1g3Db+Ns5KeIyb3LJHueBsNqDL
         PNWqM8TNPlFjC/MHqJteED8+LCyQ6P3m4Bd3At9lQSK4NVcRExQywUHX31IZjSjXEBXe
         D8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659770; x=1794264570;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPVIOrJME2+FRmlVa4Ph+81dFFJXHKxCy7RK0PFxH3U=;
        b=1XvtVuCW3JNLjKKxyV/Qo02FZYeDmyyS/W3IJ44ccABHZ/wRyGd4ZVBrmYXRxcRStM
         CsH7vvdoovn9eY1xGPiLrqKdXbgITi/gbKI9tOoCj2fy81bqrqBMjxtCNlUL0wOtENY3
         T+gL/bB5dGcmL/ageaKzTNYgZbuS9qPvinbNY0iAdk/yTwMr1ay/83pb3BUpN1DqZoJ0
         VnXBjZfY9QopNDhC+5qKBFv7ExTAbrhZcAXa8coDsHb8roILfO6QXamMojBo0YiGQ8Tq
         E9VJJK1jTwnNt7s4wBq9JTwuE+gCdIan6qiresZovswsOj+N7hpTRzsL8Beh3/GceabB
         74Pw==
X-Gm-Message-State: APuU4Z+5gp22XQl+gPTjf3VOopXVbglzJj9geOL+JMp12UptNHmkcyPi
	MsmjXP5zdUpMtMbzJ0WM58lppNIzg1AFsKuLxm6J1QmzVPjvAuYr6Y79
X-Gm-Gg: AYBFou3++GDCpGU7qRivciDbC1gV8ALINqd/ngOnJrqfgRziH87AhcwL/fOSTzljwrA
	rHua0K5KAPS0BNL1r0W850a6qsamq8WEt7Ye2d4fUD/BK9ss9xs0jh652kzHeMLULM/BKaGNaiz
	csBw9ZxwQ2d6Pwaz2FvUkqNcoX34vN1IeT6jn8P3IQt6mq6V9I/wWD0S3xeaIMiseH5ASaYZ2Kk
	/VB0TC+ojt2Ywt3ie97HVUzTyNGMG9//SeYb9wyySG5go2Gdoo9mNPoeADE2QYLR9AU/j4KXOKj
	MFJMM2VQ02amIqnXP9rP2lfHQZMyci30AfleOhgadQ1S9Qdyp5O70veUyFkgxhx4Y17mRGdw4Vl
	K4eg6qFmWDQD9hFUdJfjoUNCT8u1DipoEYvNhNjFZqDOJU5MV/KEqoD5vdhtdOilK+4rNGVRRik
	ymCt5+AZVwbLFWuND5R5VI1v6DMNpJPLoC/JEwRVgyvEw+n31fbANhEr3n15Txu7+AcEA0/NVIH
	37oJHHc1UEs6Ha1ROmsKbqynaS6dKIw4kYYM2mtytjvilLC8qJbZnxxSqPp3ty0G/iEn3o7/LO7
	5rMmgBJqkli/r4+9As31SMz+FvKofTeA4sXxr4hX+jjAZaXtoIgK/0nyxQ+MldLNGa5DLaa8k1S
	xeNoVUn5aIoB9n1hTnwcVZ475evYFJkLf3A==
X-Received: by 2002:a17:90b:57c5:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3ae89282d02mr9413027a91.0.1793659769481;
        Mon, 02 Nov 2026 14:49:29 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c583d0asm1128204a91.3.2026.11.02.14.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:49:29 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:49:28 +0000
Message-Id: <DML3BMBE94PG.3UVPO48U5LTPZ@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <viro@zeniv.linux.org.uk>, <jack@suse.cz>
Subject: Re: [PATCH vfs-7.5.bpf v2 0/3] bpf: Add bpf_path_getattr()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>,
 <brauner@kernel.org>
In-Reply-To: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 02:46 AM Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:
> Changes in v2:
> - Use a thin vfs_getattr_nosec() wrapper returning struct kstat. (Alexei)
> - Remove struct bpf_file_stat. (Alexei)
> - Update the documentation and tests.
> - Rebase onto vfs-7.5.bpf for merging through the VFS tree. (Daniel)

For the series:
Acked-by: Alexei Starovoitov <ast@kernel.org>
