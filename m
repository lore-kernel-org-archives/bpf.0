Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F482F90C9
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021813; cv=pass; b=UkiPCgBTGpdLUUksC2Gbs3TmXxcV1Pn5RnhXKLM2lWzJfHc+MHn0Y4l3QViWgboIiWwjEfVGjXIGkJVlGsW/OJ8P8Kyco3ktLzDzru8sFDPrQrT9R0cNep4vzyJrm/zYi7DV3GKQpSWBlew9IzZMPXrDchcd50yi5G67kl2fwSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021813; c=relaxed/simple;
	bh=Yz9zZrneOyk/9NHdwRKCnNRW2U97Qb6G9NJxLqnCshg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg3OV/8f38L9FYH74u1ewxosbyg+DAXohbbVozMHGl31mJlX2hryncghHve2A7dCFhbCiDWEIBjgFB7OQxIC4k1M291eYaGoqa0jxTrp7F5JWeTuU1VCU+hImldPEL7wLmmjnXZYC1VIkjWOGsz3X3hvI0xDTBCe0mSoF90fhHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmQDVWIG; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmQDVWIG"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so2187574f8f.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 12:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776021810; cv=none;
        d=google.com; s=arc-20240605;
        b=MLjCYEtSHcsW4mATA1C9ZQuPQuMP8F6rQFRJqmfZx50Tn46TXgnnTB5oER+ZQ2USb/
         UqfcfLA2CYcvc7lRp5SlaJHP7klMLWxZAvraOzBo7xEXWPfjnyb+dRyHI3IXbQ1g7+Oe
         uxY6vol+RMXqGVS/oFtPBG6Rh/8LPqD/bvJZYw2KwmzyZvs0oDAkn0Lb3u/hDWp4PzM0
         9yqmVluk0vHTZ8kpE7oKVOX6heIqwiFSWvQch6Oe+HVJtVrquoNaeXDxYls22bt4HBhI
         z8JjgD1lgzwXParXf9IW+JGxx7weE+CjXloo098TpgYQPqZ+xCtSAut9pKJxIld8B8N2
         loYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/T+qWVR/VrCxr+eh2Dr++orwtPpY2t42PcDQVspoQIA=;
        fh=biVxOfAQ8y53MvSfca8y15aWHNNleTL0sZ4Yh4c+Sg4=;
        b=WHDqV/5jXiGN7SvD+5SfVtHWSNy2jP/NyhcvGUZUVP7ZnSQ5f9i3T/FG0WrOaKUv1v
         m9rapmkqyKuR9agF9SG0eQfUDH0BOnCPfb4pHzQR+JnPEN+pzzqr59sllWU6Fzx53GE2
         gxpTKTOkWQVqpfiqUZqU/hPzUN4lVGVXJmL/A1CQ6vgYyUYxagbMN0Nfkq7MbJU7tp6m
         orz6uizUjXRo99HfnCFu5PY8z2M8jpCofD6vTghC7ZJG8fQ6R+E2iVcU74TRymq9MGFp
         v6G4HgyAQoE3SDMCChc9Ne4Taehq1ULAP+qWp1yKGQzCAWKRgzJO0C0kK3gk8sGmR1xg
         f02w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776021810; x=1776626610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/T+qWVR/VrCxr+eh2Dr++orwtPpY2t42PcDQVspoQIA=;
        b=EmQDVWIGu+RgiiSSrVUz0kTHWEv3HtU9J/zBsUaPxHD6HrxUGLdl7v+2y9PznzXKcZ
         Vv+5DtRaX3DZKYvr1Qnkk4EPQOGYsOUzqHXjFeY7CMsjFEBKB94C2+x/Rs+GrogyD3lP
         /aBCtSxq3bFrFfwjCLk0PxDYPorXe4VpTFqh9fXhdfCzVLCdQCdUumpXy/cSMozWQldV
         YJChA0gSSpnLEjjV9cEkQixxorq2BuDKu9SH2AqC4SPSxwLziw/JVx1jbOpvbqAMFrFm
         ANGHHNto2N6zGS47cOZXsHJSYRSq9NSWtJkwgAbM+NhNdBrRNXrgPL0BaBVv+RCJkHY4
         MFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776021810; x=1776626610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T+qWVR/VrCxr+eh2Dr++orwtPpY2t42PcDQVspoQIA=;
        b=YxjI1sSNp/w8G6+WsKVQ8FADEuZ+Jiq227wXUsbygIAyE+uqzTw5kFDICkm4DkASmJ
         1N/H8WbbG9mvdqSfi0LTQZqwpg+Z3/Ziq16oYXt8qfUB0Uh3FsKzFsrsH7ndNm1h13Pm
         l4fX+H4N385+rOWGhkXrBdA7ZD6yZ3ERH3TtHQuDdh0T2g9JCZjUhh1G3t40CLVpImdm
         namh7S1AJTOpDHj2vLi9fj0EQIUCVWT10GU65cjRq6DzkM3vyraAwqJql0mb+GPCeo2Y
         JdjlEgq/gccIoWjgdxLMCeU01BNlncIQPSzGdCMcQ8ZBUzGMGEYvscIcVbf2GVMrpjk9
         q+TA==
X-Gm-Message-State: AOJu0Yxz9davWHibtS5GHGmvp9Ln3cIsyrt6CFeUDhdMbgJfg2BhLBFM
	l8qlsvTwWJjlzQrNlgQ5KMg+tXi+eQ6c5o+zI5DpyiAlm3vhQpb2BZQPP2uCP9s23ObcDb/59z4
	iihcXqWaMGWnLstz9ADiWSz+wlTRwKXg=
X-Gm-Gg: AeBDiesTYo1KHF/k0IFeAg1snwplv2uRbfYiur8c2RG15dBDFfzdVj2g17N72a1+KfK
	YliVyTvtE93yV66iYu/Hjgia0GcF4haTkxuboH7OC0r8YKlLKQuJnAP+ETJ0voYs+/q7BUgQBUW
	2xjmAiUJT3DhxOaYZJuLsG6YBD8OQQYUEHkKHng2a5tS43fXkt9GgyUuoz1LEEMlAVVTHhRYO/I
	M6+iwsvjb+vQDojTrKsffASMT/Sx9l6yvyW0J4v0mWp31XAsVv6YH7g3qzr+Pg4QPeyPmyFPlaK
	60AuGlb2hJlHpuqOj43D1/YokWPXDUWvlocGAlvDueJauZYueUtaKeLyHNYqa9dXIdF5ckECdu7
	0Sx2NqKN0f8b5R1l8dBgpi8jRfR5Ffo7jwcD7BPegygA=
X-Received: by 2002:a5d:5f53:0:b0:43d:242:b9bb with SMTP id
 ffacd0b85a97d-43d642711ffmr16306089f8f.18.1776021810237; Sun, 12 Apr 2026
 12:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com>
In-Reply-To: <20260412174546.18684-1-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 12 Apr 2026 21:22:53 +0200
X-Gm-Features: AQROBzAxB-denM0tjdlCn1hnubDAxPblDl4M5-kHTJ8kIC2xHEpiWl8W5TNUcT4
Message-ID: <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> Add a new subdirectory to tools/testing/selftests/bpf called libarena,
> along with programs useful for writing arena-based BPF code. This
> patchset adds the following:
>
> 1) libarena, a subdirectory where arena BPF code that is generally useful
> to BPF arena programs can be easily added and tested.
>
> 2) An ASAN runtime for BPF arena programs. BPF arenas allow for accessing
> memory after it has been freed or if it is out of bounds, making it more
> difficult to triage bugs combined to regular BPF. Use LLVM's recently added
> support for address-space based sanitization to selectively sanitize just
> the arena accesses.
>
> 3) A buddy memory allocator that can be reused by BPF programs to handle
> memory allocation/deletion. The allocator uses the ASAN runtime to add
> address sanitization if requested.
>
> The patch includes testing for the new allocators and ASAN features that
> can be built from the top directory using "make libarena_test" and
> "make libarena_test_asan". The generated binaries reside in libarena/.
> The patch also adds test-progs-based selftests to the codebase for the
> libarena code, so the new tests are run by ./test_progs.
>

I am back in the same position as I was with comments in [0].

I.e., again, I don't see anything in the stream output (passing -v to
test_libarena_asan) when I build it with clang 23 (LLVM tip).
What am I doing wrong? (Leaving aside all feedback about integrating
it in the regular test runner that is still unaddressed, thus tests do
not run by default).

  [0]: https://lore.kernel.org/bpf/CAP01T75+BoQfQN=47NhYYviZttjCPb_CXNpa=DUC0=xSvdNZdA@mail.gmail.com

> [...]
