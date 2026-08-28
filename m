Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A393A8FEE
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889061; cv=none; b=HK+vkQGyWp0KOQi2q5dPdr2kWM47MMBVO4SdsUQIGXyVydL9ID9al2tQH0Pr/Ixsn7vGcBl/f6tIGAE+oEoSSoH5iqMG0prmJsK8qscrVlkyByFW8of4s2LcMMNBTHkzFd4jp/dm9afQn5AKoL0kDoT49By83X0h+84zQNrLXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889061; c=relaxed/simple;
	bh=kq43sLBz2ZHXLrl07cvrQHErCwpMzQX0LD1VRAlDuTU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NhaT3e6N3Qxwy50Irb9qYMiFuThCl9sfvs+gVNjhpAewq00fMcC3c/EyGctMULJC3jdjX658gdixuFUpjQE1bCexdyHIUynvZeu4aO9sMiQSUpNz46vcg6mBEs/M46MKVEc/rBIVLhvFaTiWRmwmcs8Q249ZVxgfB7ikNARaPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7U4HWhw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7U4HWhw"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-396b3d0df94so698882a91.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 20:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787889054; x=1788493854; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3KcPIBnQ86fi9vMxouOV7SSnCq2u1kcpTpfhzejq3Hs=;
        b=R7U4HWhwLrwKMC+FupEIzsfEhLvkgpLRjCuG3fdRGIljVMKbcUWbOmNIafc+8KVkyX
         qzTfcd3PB3t3/jaQD8N50cEdW4hbc410bFTwUxI7LwATn8I+Lpqa/mFKJyComo2SusIV
         xJwGDdklVmGtT46XLy5JByHJf983m3WagzUdyOFq0XRQZqjc0zx4C+jsFzpMH8TE4x3U
         Sno4HDcLKkj3+2hW/v0XuOwqDjeTHBou3395tlXX2tr2KKxqXZ5cvFzfFP5485jbhwJz
         zsvaC0BLJA/2+GdpRn71zBgS2LJuhOEGC6szDvEEJ4bDnO5p9b8cX1QskMBPH/onhBU1
         jrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787889054; x=1788493854;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KcPIBnQ86fi9vMxouOV7SSnCq2u1kcpTpfhzejq3Hs=;
        b=RMqNZLMLzcIsNEx6jRLuWQpuui/l8OFSa0xZIp8lOsfSifX3rC9su1p2k0YPzw3Zy/
         HY6IW9wq/PC1eQ5f3OZPUgtvQuwBP3fp/3zRRZJ6zA+jXqpFyjUV9MJQZI8QWoL6vS8K
         RL8YGbw+g3pm7ejZCtFcT5tadXvxZseTmlEfSrRTH8pxsxLLGzwlwteCF//h1VlZOkON
         4Ouy+vzHH4eRx14UaQCl5mM2jq6fsjI05PftBE3arTBzR6HJTVMa3lUJSi3zEEzoKxI7
         Xt7mzNFREObI7aeOMjkwDsG0cttkuvtINZXdvORgbrnt6oGpqv6OEa9GICstuT21/ean
         1Rsw==
X-Forwarded-Encrypted: i=1; AHgh+RoaKm+7kX9IC9HC6DYlmg5mUqXXa2FDvzfcI8rvqf4dHqQYMEBOkqXuGpbfd5b3OoGp9/M=@vger.kernel.org
X-Gm-Message-State: AFuF++mA0Osg6aclhR5/6RQQqyuH9bfZfRAonI2c3wA9uiFUy9ualgSe
	5z6lN+Cg2HO59MZ3hvpV4Yq8CG/rC3/3eFSsXdYW9KUUL3ASQxJCxGtz
X-Gm-Gg: AR+sD13MwUS+XNtJzdFRh1dXdqikPoIEi+BS5+JGU+/rvreMpHfTdhWGxbll7TFBsjD
	k1fn7BvrUJ9E3h2VQbb1HLG/ZMm+hkSu/ikW+MfuCqekgpGPn0OtucL0pHvVmWbJazB3Vo/nFij
	mCb6CIZ46T/1GbCxyk36Pz0Akaqf/i/hI4rXQ3kGMCXyu2FWDD51N1fIw9M7Gg2uliNq9gxOeBE
	KG1s49K4nY0c2ASFQbqpn5meQQ2NjD8cB5e5O6BPy2ngaSum3BdF3BWkgliHK2ToEqaAFKSM+S6
	YVMZGHRsEoLZ99bDjX7ckemX//NIwJ0Owfg8N09FNniAjY5L3DyR2cuUf2ysgIg5embCzZ8v3a7
	WyoQ5IXE15X9oH+8pX/A2WB+6117z2U6Y7z7sZnu41MsQpkgbvKA67eFKKT0keiGrsXWtfx2cwv
	QyTLr7iOEAPU+7bAg/Aqfn6XdVpT/HuEhekWkd046R4VQS06ap+HJO+MvtdbNrx9jphw==
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-396d0f6f8bfmr8174751a91.10.1787889054288;
        Thu, 27 Aug 2026 20:50:54 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0e0e67dsm1659184c88.15.2026.08.27.20.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] binfmt_misc: only let punctuation delimit a
 register string
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-1-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
 <20260826-work-binfmt_misc-delim-v1-1-43618adf8599@kernel.org>
Date: Thu, 27 Aug 2026 20:50:28 -0700
Message-Id: <178788902860.3236768.6730484936359324341.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 26 Aug 2026 17:55:46 +0200, Christian Brauner <brauner@kernel.org> wrote:
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index ddfd3aa57ac8..809c91d21b39 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -100,6 +100,13 @@ static const struct binfmt_misc_flag *misc_flag_by_char(const char c)
>  	return NULL;
>  }
>  
> +static bool misc_valid_delim(const char c)
> +{
> +	if (!isascii(c) || !ispunct(c))
> +		return false;
> +	return c != '\\';
> +}
> +

Is there a ready you did not make it a single && ?
Feels a bit weird to check the negative;

i.e. return isascii(c) && ispunct(c) && c != '\\';
(DeMorgan's law)

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
