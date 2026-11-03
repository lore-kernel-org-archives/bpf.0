Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680535;
	b=tzEJDBYP6wTu1I6cEV/zYbw3al6RwuFvmvRJ8EH1RKcm1iU5yonLvmTpYudC8JD9BdTU
	 t5KMOzLdyDxaB2B686Pg8W+pET6y++uN3Ae0O4qWFmfIYS3z3ncGjMc6ZzVmNANppIXN8
	 SjXrze8PyT34F8m//kxX/exyZKVgCisGArmOHoexzOeV7H0ISH+0myuYItsoTPurikOxY
	 SzMXdMBr/1aY6tEY3E2Pe7eAAhkV+MPk1GY+bSLdERsN1tCPXo0r8a1Wxki1yty4nkhhw
	 GovQUiigOZk8RiCq/Fp6OExVU2AOm/gTeiuh2SvuCLoZ6w53YrWEHPKoRA3wuaIKywA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=+haBGwyiWfU5fK0i8XKvoQcOJxAPZRgUZLulxjt6MCY=;
	b=MrzK44QBcC9o3ODgw35S0iIHwf2ophLkYVo/Vric48idcCbQOzvifqAS3wm8woXKjchL
	 0NVC+i6vIaa45L1wjDjcrGB8yDo59I5VM6hBYfBUSsnv8vJyNFFZFgeKkxWk6nLTEbkm8
	 inxz0NEbNeN0lGkmFAlebogHlDF1vZxZYynalMHTwpH24rox2NSxAn6LTBCatgS9olAE6
	 NzZe9Hs7BhydAbuJOWs5qU6iEjS7yrRBmObPUQu3dyucDL1IDUFSWQMg/oUz8jFPTptlr
	 9AhtoZFSyHgrP8sSFGAMpYF0CzwXoYjk6b2CCduD+bFqhJ1w4nXO3/eObB6C0DvbZCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EUYCg2Xx;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C22606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 04:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C22606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EUYCg2Xx
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2306709a91.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 20:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793680533; x=1794285333; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+haBGwyiWfU5fK0i8XKvoQcOJxAPZRgUZLulxjt6MCY=;
        b=EUYCg2Xxy1ACTZiwCq3hVMXK3t3no7wXjeF5y600TxKzaCOeyHe6TFA5VKnm1dGTv2
         RE09ZssXDv+aqW8biwBm1hwinP4uyCGsLICDt1Efl2hfEtiwEii8MmclL+9IpyOImz5b
         AwsxivXu5eWr3qyWNguj0S/WDcxvchQjfL/5nbHeIwn0ANAI957Ix7HyaRhauy1e+nlt
         JZH1L9XFVf9cRYx/gktVcXG8Yq1l/GDsUgyTUrH/Icd63ncCCO1oSNbNwVtDd9f91PnM
         MH3IuDh7PRkflveanVTkY2w+S8d4zVeML2V/yT4mJJegWfn0NkQlAb9eSAICdfuZtP6q
         iBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680533; x=1794285333;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+haBGwyiWfU5fK0i8XKvoQcOJxAPZRgUZLulxjt6MCY=;
        b=wJ3lEPKMBRXXjStqthoT4Q6A8W8AAbJxb/Es2pU+PVfcin6y4nV2Jb9YderAtTfn0b
         KG+GXXcuAVdfp4Mx6SKCxNgF33nUsKUWMWU3wM/7M4xgNHVbgeTeb9xOgucr73o6HkU5
         7nsZvMJK0uWxf18C5X+4/T6TcGgbPf2lRoG4pZnmr4L/vFEF3MCES/OUhaF+PM7EDMEf
         D2qVKfYxuFFM6+IQ2EurhhR886nNp2AN0CtGyM3Z1Io92Y6as0Oxg0TttjJ6nMb2T0iu
         PetNTn5ArdUYvMbuKf67moVZLIPJlgomZMCO/lITAOVV8p5ze9fhF4oQPvYEOYw9k1EA
         dNnA==
X-Forwarded-Encrypted: i=1; AKwUvBzPkF9hNyJDvddaU1jqwpv/Uim6JgphrE2ZVJc1mUdum2RpuqAtbWfsFDRypL9Cyvq9rIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z95zRF3cy1cbzov0l0+El9pG7OI0p32e60KTaGcc1waV4QmmmoK
	6g2M8Mpz3KIKgTXW+BgcS98mBbs/GqoZ9dmvmoXf1B4tuKs03uI7v6aY
X-Gm-Gg: AYBFou0oqq98lrKiFqahfuqaLyfSoheKHFtryKs7TFxsRy4GBhUPFnaiEKmASaT17Ec
	BzfbScvGBV6AuYe5lYyb8G5HpcC8yq1se9VmXZqJvxq7eygxy0pJp2VgEKDaVH2tOoFXmMnPvW+
	LzLJoP85Tkedxq511h4ZsQn45399SO1wVTtk5wRY+YPldA8ivYBhDhp159oyTfBTUh3QC9tqj+6
	ciZxIYaf6AbmxHuoYIcKDJ059OjlTkisOfjHF7ADiw4fwgpIl3puoKxtCZnwyUn+/c28aM6RycG
	WPemXaMojj5qoQuwW11mL3PJkeRyytNgIkI/S0XlEv7yAjgQ4+VzKv6fqjNjHbj7guOsEYE/6cO
	zWYqkn/QH64sD2Jp27k4Ui8/zQhMdula+/VcwLWAHQlixYIOEeDUjFpRa1rvtPyIlXiQCFWPuRi
	oAQHaR0+D9y9n1UCTIgS4K4SfW/xUOpX7RXCtPvL93KNpoXCVOSrkf3IFGwhtOj5LaOcwY9MRFu
	e9jPoHPiKLcyDxP49OYVdIwJgIuxu6fLWdFDIglURK+tYLYCqrlz4cpIlsucINE1yAb9g3YAxeL
	B7Ulr01wEShXXgWrwxMVxP2TumjsOGpaSnHtOSSv88rUEMhyDOhRNViRIr8nSnjMe53KEWTRphX
	Q8sWmvx8maFob6QmNESOI4iXfjlhrFW8FX2A=
X-Received: by 2002:a17:90b:4f87:b0:3ac:af8d:c839 with SMTP id 98e67ed59e1d1-3ae897f6e6dmr9433576a91.35.1793680533365;
        Mon, 02 Nov 2026 20:35:33 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb91e5sm9616698a91.0.2026.11.02.20.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 20:35:32 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 04:35:32 +0000
Message-Id: <DMLAOL0238CH.43SXF0SFHONW@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <llvm@lists.linux.dev>
Subject: Re: [PATCH bpf-next v4 2/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <socketpair@gmail.com>, "Quentin Monnet" <qmo@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Nick Desaulniers" <ndesaulniers@google.com>
In-Reply-To: <20261102-bpftool-plugin-v4-2-5a853e973db9@gmail.com>
References: <20261102-bpftool-plugin-v4-0-5a853e973db9@gmail.com> <20261102-bpftool-plugin-v4-2-5a853e973db9@gmail.com>
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

On Mon, Nov 02, 2026 at 04:44 AM Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org> wrote:
> +  else ifeq ($(words $(LIBLLVM_SO)),1)
> +    # Don't link with libLLVM.so. "prog dump jited" loads it with dlopen().
> +    CFLAGS += -DLIBLLVM_SO='"$(notdir $(realpath $(LIBLLVM_SO)))"'

sashiko is right. realpath was my suggestion, sorry.
Today DT_NEEDED of bpftool has the soname of libLLVM.so.
Every distro makes that name visible to ld.so.
The name of the file behind it is up to the distro.
The two are the same on Fedora 44, where you tested.
Where they differ dlopen() fails and "prog dump jited" doesn't work at all.
Pls use the soname. Something like this (not tested):

    LIBLLVM_SONAME := $(shell $(READELF) -d $(LIBLLVM_SO) | \
                        sed -n 's/.*(SONAME).*\[\(.*\)\].*/\1/p')
    CFLAGS += -DLIBLLVM_SO='"$(LIBLLVM_SONAME)"'

[...]

> +	lib = dlopen(LIBLLVM_SO, RTLD_NOW);
> +	if (!lib) {
> +		p_err("failed to load %s: %s", LIBLLVM_SO,
> +		      dlerror() ?: "unknown error");
> +		return -1;
> +	}

"bpftool prog dump jited id N file F" fails here too when libLLVM.so is
not installed. It doesn't need a disassembler.
prog_dump() only writes the image to F.
But do_dump() calls disasm_init() before it parses "file".
Call disasm_init() after the arguments are parsed, and only without "file" ?
It can be a separate patch.

Also common_options.rst still says "linking against LLVM".

pw-bot: cr
