Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F172E353A63
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316891; cv=pass; b=KjoSaIICXIybhY2pdMLmHVowFrJm3tZw82Z1b0HWYOylojLeQaTzrfq/jB9XAG2hyi3kmT1Mshbm9VcmOLibUSgVPmxfbQ5NmRFdsvXmllDrUN+rcig45OLQAS6/mYxX8RDVKElT7R8VH5wfeaHb5CFW3cmLNWWpk32gpjCVSZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316891; c=relaxed/simple;
	bh=JFKZodhXL6sp9/df95vCBiuoHLz8waYxdzOyhjMJxm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJeaD5zzySLObf94rZ2NA5WyRcvS0sdXAB/5JkjjEI392dlSLa8GeXG/bi7ap7mL8HwlpRNOK5StYdCWhdkLXM8h6SE0DsjO2OB19085yAS3FBZHi4fDtOX5BNQ9+06P1kvLKaTi0z2zoa+3PX4XLYDhbYAGV1DLQ/amQp2bEjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nluK02xY; arc=pass smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nluK02xY"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887b799104so135010f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790316888; cv=none;
        d=google.com; s=arc-20260327;
        b=BaeYYUDpYHKMalvsKg4PHPicXr0P8ob0NAA80I3QgEnNLvJLDG71WmeaF1jH/U/hwc
         VLPwovFuSqw1uZiAmOzd0uO3yRWcgZOQoKOGXBU3J/Kq3fSOYvn3Kv+TurARhyfkW4M9
         7OTvksYjufI+5djFuq+jjbWoaFySLr4/h88MZOuLPQ536GCzeX8up34eBhlvgh2O/2qe
         4WRUKYWiv0PMA9IXR6YDaqpZa4m4csSZDu9dd85bGhnWORvEP+xatrPinYIaVLqfBZmE
         Mh2ZxxaltkVrf5SbMCUIk7svNqkls8OmSwu4o48+WnPT4f535tOoWywyngTBwUFJLMw7
         yVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JFKZodhXL6sp9/df95vCBiuoHLz8waYxdzOyhjMJxm4=;
        fh=lcaVCoGdMDvc9x7mCFzuVPCqc5togrPFskRRL3dQVkw=;
        b=HJTIv0fDqpkNM+KzkXCwkbsXGOIvHWdEgMWwq4Gp2oTzXtZBiVRrsn/IqvS/PLKwr+
         aF8+6QtRws8CnCWzoPtdEp73ZCDjO7okUrIOGi08KrI0/wfcZBOzC1iW1hujC69d5WLk
         dGMiXiGoerXW+anAslrweBASd3gypC6aUo3GgUGfuNLpznS7NcaVewMddkjx3Yytn/gy
         0MIvRK12jTNSywiG2UALdUaNou1IMfONDssiy6sI350dJ5bxsyKAr5L3ARQRotFOdiL8
         NdEyOf5RaMqfSScUxU4tSoYEKGx0/kY0gy9QLqSNe8tGox1KjKN0Pbaw9kgI4CxfyGw6
         5I8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790316888; x=1790921688; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFKZodhXL6sp9/df95vCBiuoHLz8waYxdzOyhjMJxm4=;
        b=nluK02xYgSU+YYOpdUzPSlUKub3sehbT7jPuCP5fx59wVkF+e/VBAGlw3EMtKLmO4m
         ihzlZ++P3CxFnEO19gmzSQ23EVp3zxdqwxh+EWP3I5MoMLsppqbgPtTt6uA0EQ+/aLwV
         argpWFs7CyBoOn9u9yKdYL7NdG0XVlHRfAh6ciGcnNQYjwkQCtCusDh8TFGMOQKxYDaF
         BYX8KP2CYKJ1l2HMTU5l+WrTjr7Ta/fDwBDcSlgTBybl/M6fTQRjkLOO9SWgMrfS+FcK
         lqedFa51TtfucfBRgP0RghuzuU4PcNntboNJiK4M1zpp8iFv2GQImW3xhm4X9nPs9Y1t
         6r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316888; x=1790921688;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JFKZodhXL6sp9/df95vCBiuoHLz8waYxdzOyhjMJxm4=;
        b=IrUMEPoR1SKOmJqMX8+FCKY/xzRJm/x4Th1PfCKyvlodLzG2XK6RIUeEDUzr6YCW/j
         fLG3T02y8digJz6yqiX/zHx0IorD5tP38eVBZMJqdCnteWX7OcG8IXK1aGxLo14eZ+uD
         TYJFQvaEAoNvINtwlR/VyUecqcbsQ3eBD2kQAoTqBwJrrZqeDjDGsKtSmJgMlu3a/UP1
         qXLabzqqjK/USfeSu+tVRGIEDngHi7W+rFVuTl7fkCzovJSPi3jOJ3YrRLO5cDFTK6dy
         xatrD6q3PyODZYdYjw5K7uzdZjMRa0GcLK/HPi18xX1n7oP1YQ8z4Looc15WYDx5D8mW
         l5qQ==
X-Gm-Message-State: AFuF++kklVhNtPGzK/Dq9Rb1zcN2gSyI+5thbZ1QCNmyXOkaPXM16a47
	Ywb5LgWbe5adUOKgReOLimBIxRyGclurC+i6CwXK/5jgJ6TRE/KybLQC7gYftkOpS7Jj+oM4CgD
	+LOsAtVY19y2H32zQS3R3G9IDHRLsnyJ/XQKqebkKukHA
X-Gm-Gg: AYBFou0UvhQRDJzFZyeFsU6xJGJOl27jh2D6l2TGFyWBEXWg1IowsuO7BjNGO6v7K4B
	k6CNvpoCw4BVPrKRYoe9UqnasbcxzF4x6PJOI3z90E/mqtENjn4nXIXn+bCxytUW0a9G15nCpAK
	7SCMXeSQxVQr+k6KKliNzkOOOabQd1Mff6msVFcWM9ph6tiBd5n7/NYbTERbKefFFHHGQ9vEWhp
	COHBPFUefcQIZJMsudAAvh3sO+YLX8xZ6CY4lLYgsW3sf1oWmIrlKGOumfI3+UQDzLaD+O9A5OJ
	6Lbf419YWln8JVFNojXa6ILpz7er1uHO8ccjz2M8dD54pKHNn3ln19bP0IwRTc1CETf9ZRC0wHw
	+ZlwM2V+NtVaAG8lMRDnQPdDCH7hRLYIzOZo0Qj7QxFHEuWDP8YjxbFdFI//lYkVIHcg38fJJ4t
	//GVRrXb6bP9PB7C6rfUe0eJfBmwVuPpY=
X-Received: by 2002:a05:6000:2583:b0:485:8ee0:dfc8 with SMTP id
 ffacd0b85a97d-4887175a69cmr9416549f8f.41.1790316888110; Thu, 24 Sep 2026
 23:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925045536.1480933-1-memxor@gmail.com>
In-Reply-To: <20260925045536.1480933-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 25 Sep 2026 08:14:10 +0200
X-Gm-Features: AclHuK9Cf8-24XjUn4ZA_5kH5CB55780QpukwOCZYTqGKBWw3etS60fuzpDU3IQ
Message-ID: <CAP01T753PX-YHRg6p3HwfA5XYN1u9Z6A8dH7XFKAjN9+tJi-tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/5] File descriptor interface for BPF streams
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Sept 2026 at 06:55, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> BPF program stdout and stderr streams can currently be consumed only
> through BPF_PROG_STREAM_READ_BY_FD. This requires repeated bpf() calls and
> provides no way to block for output or integrate with poll-based event
> loops.
>
> Add BPF_PROG_STREAM_OPEN to return a read-only, close-on-exec descriptor
> for a program stream. Reads block by default, with an option for
> non-blocking mode. poll and epoll report readable data and report hangup
> when the program is freed, while allowing buffered data to be drained
> before EOF. Stream descriptors retain the stream storage without retaining
> the program itself. Waiters are notified through irq_work only when a
> publication turns an empty stream readable, as bpf_ringbuf does, so a
> program whose stream nobody drains pays for a single notification.
>
> Expose the command through libbpf and add a -w/--wait option to bpftool
> prog tracelog that blocks for new output until the program is unloaded or
> bpftool is interrupted. The default dump keeps using
> BPF_PROG_STREAM_READ_BY_FD and exits once buffered output is drained, so
> existing scripts behave the same on old and new kernels. The legacy
> command remains supported.
>
> The first patch fixes a pre-existing issue where empty stream writes
> allocate elements that escape capacity accounting; the readiness tracking
> added later relies on every element carrying data.
>
> See commit logs for details.
>

CI failures are unrelated, once is GCC unable to handle code pattern
(needs to be silenced in CI, like other existing stream tests), the
other is existing callx failure, which I sent a fix for here:
https://lore.kernel.org/bpf/20260925060945.1993547-1-memxor@gmail.com
