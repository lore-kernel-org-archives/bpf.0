Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752676;
	b=s3lQTXjIu3aGi7AqgPJe/tCW/xe5iAUi9KviSxgFGoK8ZhAOD5dbzvpzJd2rwpLEGP9q
	 A7uEH1Q4BBzph0n1LTNh8mpGUafiRsFbciXaMLv1EGTKkB0PM9y3Nb73ssOE4y22MFGLk
	 DPlsBgzn5nkvCvrwUtsnkPX9GDHck57rtK0vfHHwaQ583zoS9yPvP1TjTMdfAkJ1/+veJ
	 PIPGY+zDE9lMitXhyhhi0RHahCd49cky4BHC29ZQLvM6m93fs3mUTSH+7+Kp2lgZsSGhv
	 XI9MA80FNw5qZMaOze39tErIuFwJKdNHu80eI2fZcQyXyIY8U3EB0iy3ozSg1hUZ1WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
	b=TAYuoLnmOEPRk02U7FRGqHG0ypTW7r5IRvzqLe4S5oncIWuDYnWuAEK5C5fIerGgDlt2
	 id2CGXWoKslrZYEgnqHRGQav3Q+SS1mVLPssuFK+rtv+P+lk4+LMOEboYs7qWajtLyN0P
	 XDiZBNZcrnJSkD739/NbKj4KPSNQmIzif+AExGV3t2a5JrnrfDqIk/cCMHDF7fl76hKTs
	 acvd5b6HAoLrQYDgn0DI9SIqntmUjyLJ2O1rLognRlgntExvZrmzerVz4HaAoWZCLnSZ0
	 KMHaJZHhQ216ppPbeAvtQnPu5vihsf8NdBnm0mbJfxCexpg3/oVt5cTRASbpbkX76Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxVes4fN;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C4606A8AA
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B8C4606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxVes4fN
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so19855475e9.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794752674; x=1795357474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
        b=jxVes4fNS9TSgGvlHsTT80+9II9XinvC4prossPItwxQmdIh/ly0jdC/cdyT55vVR6
         dxr87FlrY8HaEzKWL1k6AkuqQTejZzqNuP03IkWn/1QKMcHCGusJm7Uzh90VmKNatLHN
         /Ur+ln5v7C1S9XPfNu7fKUrI1pDdBwtHp9o72Tv8ddrZYc02/UP04z5Cj9qKvnMUiuBc
         AKlR1i85YUHuEqLhR+nPnOGxB8gyhi3BmtQiXq42P2XoLdScRFWDqb++9b0P9t/EHP1y
         PjbWv5kEkbF943EnXhorY4a6wJ2J69Bqn/WcjcubzUA5IRKt9NLekdoBKWqKwl/hWu6c
         NQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794752674; x=1795357474;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
        b=RlIS5jsPu7fWSQhI3AQ1Qfd1oKV5a7wWVZA7Y6Dm4u11kKobffQIX6cCUC2aH/oX+t
         MJnsMgSdvv1TusFezY+U5XmFl5LoM4rLLmMvew+AlKxl8Gt1ny1iVaiXM1bYdGOF1n7e
         /ET0yG2uKnLe5WDUF96NB2Rlu2Y4FCUFCPC/VeEguHJSgaU0AAntb4/f8X9bOXGcwlME
         lTqH3VsXbfs8TbQhTkoJBmjlqKyqWdh5h+s4dbnfhEv7U8wghqJZvtEPgUSVzH751LE8
         lGHf4wkaIiyBkP6mPglqgWhW1+29kkKaAV9+8Kfm4p90lzinSOIeb1Vlq7J7QU8D3gOM
         pIeg==
X-Forwarded-Encrypted: i=1; AL+hErFLqtfFxz+65IINjR3JWPG0dM/zFZqoq2ryz6czL8InuUtx2h9IlSL55Q1eSCC2EIhw6CY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mKHX19M8SA5yqYQOPKWRyOufU0mkavUZmduiDCxBI84SjLvMk
	5ydPXDSm5WK98swfIaFp1wzhOsNgFA1a7tl/4CHtx4ZeP+h84UmB7xf2
X-Gm-Gg: AYBFou1l4oiFICSs5GULHWQ/DmIf3ZzRCTXVKKcjBByKSLCwLOWftzNh8f0NtYaf/gX
	JA+eaY4G6M1PCaWsgNO8TShDdki4zPEzRr6mInG4G7BsodqmwnGbBZhg0lMeuzw7qWnemcbN3ee
	RgVr/InSnvmARzLWxDyC3KqUHsMXUtCTSYYs44M0rwEArsVaC39veDCPPVM4fe/W4w7mku9ZquO
	WF0ticauTBzpGbwPcNDji1CuzQpojIiltGN1wPHsz/L3ijlGXUUIvo2Ec/x6SgnHSBhIiC3fyKV
	fjgmMXEC1UxveN5VEvRGuiP+699OYhuSZIRt27K6nDai9cNgaA9OV9/qiPcmhpvON3G3L2LAGIM
	dmmalJBfcJwMD+4kVkQGu7OkzWGptha7yqno4kis/FtA8+0c3jbc1SCNPQiEXHJ7kovyivAUzX0
	wOUONFL8cizgw2nBW4R3wGr+UjSJL87fIagJtIUsg9F5YWc46OibozuUCnrji0I85RSLdE+bGFV
	MEi11MA7qfUdMAXn+kBOeyDzsHIruspMveuA4qxpjVDzAvJuvYAkDJPVDhmKd6KpTgtz07GOSAB
	WMYOKz7li42CDxhsiPzBwzHAEt6M/9xIbjn9pCTA/jJPNYXhvLNIj+2M+gdbfXAEVfvc5wlUj03
	nO9f2Zrq9/Y4=
X-Received: by 2002:a05:600c:c0c5:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4bb55a6602amr130912825e9.9.1794752673813;
        Sun, 15 Nov 2026 06:24:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm318854915e9.15.2026.11.15.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:24:33 -0800 (PST)
Date: Sun, 15 Nov 2026 14:24:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 and KALLSYMS_QUERY_BY_ADDR ioctls
Message-ID: <20261115142431.1587690a@pumpkin>
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 14:12:45 -0800
Samuel Wu <wusamuel@google.com> wrote:

> /proc/kallsyms is the primary interface for userspace to query the kernel
> symbol table. However, resolving even a handful of symbols or addresses
> requires reading and parsing the entire text file, which is often several
> megabytes and takes thousands of read() syscalls.

Separate from this, I've wondered about separating out the /proc/kallsyms
code from the code that actually handles the symbol table itself.
The two parts are pretty much separate.
IIRC it uses a static function to get the symbol type (which does most
of the work of getting the name - which it also wants) so it isn't
completely trivial.

I'm pretty sure all (well almost all) the changes will be lower down
the file than my changes and won't cause (hard) conflicts.

I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
in userspace for testing both, but had to cut the bottom off kallsyms.c
to get it to compile with a sane number of definitions.

David
