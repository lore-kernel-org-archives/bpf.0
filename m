Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1738F92D
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843556; cv=none; b=qboo3rihR+o3I4Hj/6jHJMvFvzEpKiVfQECAFm0NtKVdVKJJU4ah//ixfQr/rC280lPyPV3Xfom8v+A/G25rwQmfhcy9qTMlDfP2Zb9piV6D0WpQso4MR3Fi29C68QmhEhXBuW/bAEDJ+gSsLpNiupTVtvB/Mc8saz6e2FwE7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843556; c=relaxed/simple;
	bh=07S8qGhUlGHHZ+Z7kKrI+FqnQKBLMTTGSDN2n79cGXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sv3t3JsPJZQ8abNxo0lciP19JXHulHkHzR6mW5VvuA+WkKzxRD5oQFH1zdxhcchSe9rtZic8zOdkAVXFhRBQe3atzzNke0CVzbL6tuX0p/W/MX4JFBM5Qp4VQGCP48fyGWw5d9gHYtqDk9WhSNmwQz6cAsl5BISGPrBwalGvT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SO+yqBMj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SO+yqBMj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bcb5370bb0dso1380224166b.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778843553; x=1779448353; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=77xVpw+sT9Jy+PbMBmIBkrl0llFT6NHnPb++9YCl0NE=;
        b=SO+yqBMjbSgATYtqA+vV6rcCEBW84KWwMc1WzrTsjdLnH8emmQDVu9b6xF8URfsQTB
         diAv34V2Twlk/vAvmVBkQQGSy3fM/CzuEfu94E1l2BZTf0DeggbZZJfQIQUZWYOhokny
         v3QPegEel69+M2ijddl1DkcvbXFLJeGrhq0pXB7I26aHBkJdm7TT7RKTbSqjRNHyEqTL
         y7Qu+cKF3zeiFHpE9VZTQ6rKbg1SlR4E0WcT6vj6NyHtMi2FMjoxTrlOeDoayi0R/nES
         r9oYa+XCXkc7nym0Bxd9pFJVeBHK+uPjSqPrQfdRSti8Z1AfgLcj7J9V14SEEI5l5xv7
         DGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778843553; x=1779448353;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77xVpw+sT9Jy+PbMBmIBkrl0llFT6NHnPb++9YCl0NE=;
        b=G67dvH4oGiR7lLeu6bccH/4cbr8kA7NQC2Wa2m1m4VfG2znJ5JfMywgIQBUdSK4y2h
         CZRZbjMF2ftYv6etQ9TD5scn+z2rw9wWbWRqNJ4wm4/uMmiU5DsVO+66VHf3bHLGdy9U
         ioVFV/6jbwsuvDiOrgGjJN6qAPAvkAMgM13zvdxp1LjlyQ67PHBW0aeEvZCrP4GFgUaH
         y36fGS/HwqByL8ixKgvvJ6RT1gWSsGg7h8jh2FYypQY23pDC2xqThU9am9c8fg1r+sDY
         hrMnGwtGIrkfw4x1RQ8Imc2F0sDPbxPDiEeLBo0fr7CIjJreNuDV3vo/p8P7H08Z9vly
         SxXw==
X-Forwarded-Encrypted: i=1; AFNElJ/EVsd8jqNkLV/u/C0Vt6KJI2XXiRZouKHdAUjYqWnGMPhniN8r8PSm/RskK5rZkLxmTNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAJPE+dL+D/OIjhlVC7LTooo6H9i0LfIwyDURAQeobwr79OOs
	W5vPjL+I005+A0vk5CE1/uonEth4Luf5K+8R7DFK4ttED8d8qJ1Z6H/yPHjdjo8AuiA=
X-Gm-Gg: Acq92OFcPlCBBFUUnu+IroZJGSH84DAc1CGx9qRAsid+oMKMTQe1t3MQ6yVCFOaaC3H
	tKEtUaNcfMKbaDuNLcP4Cg26slrQK6WtK4JpQ23Iul1ZZCAQMrE7zd7OncIzO+UjlJU1taAuKF8
	HyVRCB9MreuXPkE+WHZfeZbxqzTinnFU/6vJz33fX3Y1X+dZd4HKaKr2Uhz3RbjFf6UgVc7+8T3
	fvQANRGC6zTlr2jp73w2jqRr7kT+DgsEAEIUK3Mo6eZlA9McjZ7i3HCSnuQ8avZoI8TBvICnZEo
	wmv7n+alG3AhyP15ZfdQQwHkzNTJCU4ZciEL4DFVP4RfbMrpz5mtah3m0CyGOZawy0V+lFa+gUt
	ychMerB8IGWSYoQ5S1aRQD07h/EcNobnZGcGu03rXDnVwBWIXadDrsRnloMqmAagblzbr0xOBfV
	SxF69kN9IxWUTZRemy1XAV+x4x+w==
X-Received: by 2002:a17:907:94d2:b0:bd5:2e64:aeee with SMTP id a640c23a62f3a-bd52e64b4b4mr8208666b.35.1778843552408;
        Fri, 15 May 2026 04:12:32 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b3e8e5sm1885489a12.4.2026.05.15.04.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:12:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] libbpf: Change has_nop_combo to work on top of nop10
In-Reply-To: <20260514135342.22130-3-jolsa@kernel.org> (Jiri Olsa's message of
	"Thu, 14 May 2026 15:53:37 +0200")
References: <20260514135342.22130-1-jolsa@kernel.org>
	<20260514135342.22130-3-jolsa@kernel.org>
Date: Fri, 15 May 2026 13:12:29 +0200
Message-ID: <87fr3t7wpu.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 14, 2026 at 03:53 PM +02, Jiri Olsa wrote:
> We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> fixing has_nop_combo to reflect that.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52..7e62e4d5bedd 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
>  
>  	/*
>  	 * Detect kernel support for uprobe() syscall, it's presence means we can
> -	 * take advantage of faster nop5 uprobe handling.
> +	 * take advantage of faster nop10 uprobe handling.
>  	 * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
>  	 */
>  	man->has_uprobe_syscall = kernel_supports(obj, FEAT_UPROBE_SYSCALL);
> @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -	unsigned char nop_combo[6] = {
> -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	unsigned char nop_combo[11] = {
> +		0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
>  	};
> -	unsigned char buf[6];
> +	unsigned char buf[11];
>  
> -	if (pread(fd, buf, 6, off) != 6)
> +	if (pread(fd, buf, 11, off) != 11)
>  		return false;
> -	return memcmp(buf, nop_combo, 6) == 0;
> +	return memcmp(buf, nop_combo, 11) == 0;
>  }
>  #else
>  static bool has_nop_combo(int fd, long off)

Nit: Would use ARRAY_SIZE(buf) instead of repeating the scalar value
in multiple places. Otherwise:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
