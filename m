Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867836;
	b=UuJYjCoZBQwxVaEtfIhIePv1myPOv4CzKyzy2gjN3aZjje8ZjwvJketqzIq8DC8YVSX7
	 vPHUF0cyPpZVvUc2QgQOETyL9g27Wcb4mLudC8pyVmE/duexByOR9YhchASHKJ/kBRhsK
	 0IXE69RCzwMBLrBbcc0ZJP4fCGt5zhyYXw1Jk70HELgJ6BveG63Li7i6FTvdrUWRrXSTy
	 cYco23NvF87zL3Msk924YfF0qC9yIDRM3AauZjPLVhQs02hjr3cjdvSKEBE7Y8S2t6LEi
	 GRUW/BhVUah1+g/C6J6yNwNpIg0sERsqPZYH+V0LpGywZyXChsq8XWBRhscGyO9Ggmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3NU/G0xlaqrO1C6pRG/U/VFMHzB1bgOCQipgiOlTFyw=;
	b=XzYyePbaDPEoHs9KcSslyL4ctpsaIp+drWY18pzpmQyvgIUrlvS/eVzKwXFZkSPQwpNQ
	 8p6DEFoNg28Sp5ddjuPHZUeS06cIx0wUjuaf+WFUpC6x0LeFG9FfGK6sGkv6nPzBayBf0
	 YtY6FYxD9RILwcg+9eyy3h+I8jJqM2mi2MzpQN0UmlcCypw+6g4BdjiNGgPq7dxnphOe/
	 bzNz+2GTB3Vf4qDef8jIyGCJ5SEYtGRm36WSKJFK2lk1rs3VGWLuEGXcUB96G6cuQAFvM
	 DKh0dHsev5TUC+Kwlr5J2A8RBB4a/VxKnVhF4tYQkqL/FiR78DkrVSyJMpkeKZkARWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCd7OApu;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B3606A32F
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 08:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6B3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCd7OApu
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so18366945e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 00:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793867834; x=1794472634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3NU/G0xlaqrO1C6pRG/U/VFMHzB1bgOCQipgiOlTFyw=;
        b=TCd7OApuoL5e3stS7D1Cly3qhe5s15objHkahbF02Otwe/HfYG0Lej3tHT+vvUg9fX
         wM7/rDK0ZKfkmIKirGxQ4lCbjDhxdGdeY3tFpTNzaQ77gZIvgCQbEVQnLYSoAtRd/F0B
         B3P1GQCvO1Ey7jnj2cNDru7e/V3p7HMD+mzycRvyeaEFiOSwlimL84H/o+T+Sa7HeYX2
         947109hybPJgL421as69RaLomQaFhr95brhMHrb/jbGJdfW/+OsFTyr4iOavfSJAjTq1
         /9RC8ylZyagig84Z8nnznPCc2Fzl/McnQn0vWxi72uOtuqDts7dZxdxnDXtW9AxgOA1e
         XQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867834; x=1794472634;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3NU/G0xlaqrO1C6pRG/U/VFMHzB1bgOCQipgiOlTFyw=;
        b=B/xYnjmv+8X50Q5B+mTXPKF9s6dFoqfFu29LTgVtiOy9AB3XVQ0dTydK63z3YYhfmn
         TAjGAvruuppfXZs9YtgK3O7b5y9nBsW3g0A+pbkYdBIitN/kK0Ck/x4z70NUJEGkXgFy
         2xu78xHisOr9ZWtwzlGz5FMLxn9jXjwwDVdz5nCd1D35l6Omx1VBJHOxPwSRM7i5nJWp
         Jkdn93EtbIYW15+qsGwgpi/9bHi8exWiN3cZYGBlbFkxhkCmn/8MTuARZbh5RjU9fXU7
         YrJQ4YxGlvEp9OQNVdWR6Pi53FFg0MZ6q8irMXrdBKrO87X1ztLyEXuLKsoGnJuNUM0f
         CKGA==
X-Forwarded-Encrypted: i=1; AKwUvBwpCeBWbVsP7ID+oi3gWw8k1vL8iE2CCAF+Qazh8cz8S7LpaYHLO0sucIamUF04fNpxqgw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DezS7sOGxlw0ZtIzVXO1IL7iiEBLhVjSJJsQNFSNfhR8GE03u
	V3otr8qdvM4tf9kWqg7IUSNfkeVyxcAaw3J4jIN+stkWizbOsbPS+TYD
X-Gm-Gg: AYBFou1YAi68SA8A7Os5FoN8dya384Qjb3gIEwmiMrmT/q5ONEF+MljSvMIX71YSaaY
	HR3EQdgTnfQ674aXzVea1cIIUSvwbdPl2Z8rebxO8dZ+nkL9+a52SZAnylSzdVtKdpjMK+xdMWu
	VbqYuPS537txulFIfM9Hpws8lHFqCplP/wBT2DDrcjtynga/CGhL9P3fX89FIuWIdr1zhbEyW0f
	R4Kcd/m5n9UqNeKOPvgfoOz1zgHIQvrfe05/QRmfzKF8epBpJyQvl6UdVokW+f/xOcaxt77boXG
	ZgBqQgtpGvG/G61C1qi+Bh2HUNM3YIJsDSM60ghhaYj3an0rYmH0go11jUsbkCYNDlnElGnEUI0
	+YLzlYccOSPoaZj60sLAuL4RKdbcsU1l5dbPt6DyGoOff+9AODAm9hXGJq9Aebw9fihL8cm69At
	xbG/QhT/qITaXm77Ty40HdO847QiaBee9AcKVpEOOVU4pT/O+/nrC68rFn78YvMg/Ac0dvYCuSZ
	cyOmiCp8xPzk1t3ZIXxNrBLfydPc1VBoBRw6PEV0mRR1cr2pbHByLH8bIXIMiJ694OZ7TmRB+s/
	Gad29F9ajs56s7GeKvOQqS2hBRhiN4J1cCM/OGHg7L+JLB9jDreJoHR488Ehz4Nt
X-Received: by 2002:a05:600c:4e88:b0:4a3:59c7:f226 with SMTP id 5b1f17b1804b1-4ac16bc4713mr417554995e9.6.1793867834333;
        Thu, 05 Nov 2026 00:37:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cae5sm75471835e9.12.2026.11.05.00.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:37:13 -0800 (PST)
Date: Thu, 5 Nov 2026 08:37:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to
 /proc/kallsyms
Message-ID: <20261105083712.14847dcf@pumpkin>
In-Reply-To: <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-9-wusamuel@google.com>
	<20261028134012.01d52e94@pumpkin>
	<CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
	<20261030100215.6f8e0d4f@pumpkin>
	<CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
	<20261104142307.431fc12f@pumpkin>
	<CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
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

On Wed, 4 Nov 2026 16:05:52 -0800
Samuel Wu <wusamuel@google.com> wrote:

> > I think it might be more sensible (less pitfalls later on) to return
> > the symbol number - not that of the next one.  
> 
> What pitfalls were you anticipating? If the current symbol's position
> is returned, userspace needs another ioctl() call and an -ENOENT
> check, to learn that there are no more matches. Alternatively,
> returning the next position means every call pays for a look-ahead,
> which for an unfiltered query walks the module symbols even when
> userspace only wants the first match.

I was thinking more of the kernel api.
The 'position' is just an array index.
So a 'read by symbol name' would return the array index of that symbol.
A 'read by symbol name index' would return the name (uncompressed) and
do the lookup (binary search and linear scan) to find the value.

I've used a bit in the 'sorted by name array' to indicate that the
symbol is a duplicate of the previous one.
So checking an 'exact match' for being a duplicate is cheap.
But for a partial match you start needing the name buffer to be in-out
on the read-by position request.
So you start needing 'read by position' and 'read by position with
name compare'.
It is likely that the caller will need to validate the name anyway. 

An 'interesting' idea would be an ioctl that returned the value of
the nth symbol along with the name of the n+1th.
That might get confusing though.

David


> 
> Andrii, do you have a preference between the two?
