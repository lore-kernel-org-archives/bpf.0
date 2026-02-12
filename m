Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7E3EBF17
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770876950; cv=none; b=ubOsIzDQBW7AInXnZjs1kVSXWIBexEjsdoAISYtPAwaIz5q/v82sUwJdZkQXEur9KQ+yO13K96v8lVS3bkOqH8TPE8vWpiPechbZjy3QQAMVOfE6k98zZ6JgxrJMK0S7b4X49L/d6V0N0BAMI3/pR1Q8IEdWjex3qQgotBe4sgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770876950; c=relaxed/simple;
	bh=EAABMlLMOTX4KR6Lr3bJimyzlHr0JJGfbl00FMTGZsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMVtZP8nJW8lFcGkK566LDj7+3yLDscUgnGe/gAEmhnN6EGsvZgznkU/KJBtaqJZBIsxyiXHSiU9fEXV54L4owAiHoKbeoYAQ6I420vMahj7eWytfIBjdMc5Rma8KUXtkGuLjL7f74d+vU/pSPBd2N/o9eqeqsHOEewEd3lJ//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SIL5+8Fs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SIL5+8Fs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso17513095e9.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770876948; x=1771481748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CbtJLFCfydHoO/NaitRRJSUrbub7vifcb+EcQZ28QCQ=;
        b=SIL5+8Fs/5ujzei0RKxin0lZ6iPCfZfQeUlW5Wrj35S47LfztMGXJHtA5F/lWc5Wsj
         1DH2Retr+FfQddsYWH9UxNaJpxGOhE+KJ4ZL3Avtme7J8lW211fN676YjOz4Us2KxkSu
         xcyK4AClP9oo66WSQeYHToNEIwnaC2cvaMbLFuHSYulfHPDlEKBPN2x5ZxErFrpV9tzC
         H95946yOwFL5xWcLnWFIiF4RMIPwxXnXy2H7sC4tNws2HVEylphMwkWai1G1NRtEJ/dE
         TWOEC2ZTqBN0hvJieKxMllQUZJ2RjU4VJ7cjemYZUO6Xhd8Ft3M5BEZ2K1cShfQGnwXI
         fn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770876948; x=1771481748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbtJLFCfydHoO/NaitRRJSUrbub7vifcb+EcQZ28QCQ=;
        b=lmYPOhRky1NE32FlFeqrr9RBkV8KqQLaCr4hQLgD6/pgS6y7fNS4HEXzFq4kuUXX1d
         UzzVlWr9RS+a5tC+BY9oDPPRj0c4xC47K9swwzGdfYwz2DnGhpOp/DyPHHVzEavWUsUq
         wsXDfklnJWhOWsAXUB56lrNYf94BCEndz8YYqRyM6161w7+ZGjmBhiL/0XJbmRcSOOPg
         tF2slEQ4qjJtMrUsSCJov0iS4CwIQT0muEsZglFsgMs4i2foYb/regqw3iL9oNdsC+ol
         9tolMOhoKACCRBXFq8lWcUdXB7kyZgKEvFDhGzkv4RMeh2ib2A8c2olOSz01SvC0zELj
         nFuQ==
X-Gm-Message-State: AOJu0Ywid2q33VXqq5JXyhqaCwzy2N9RKW1yWeg0ORPUbE45qlpcSHdl
	3P9aliUIYdj+47ewFxJH+K6QwwHiSVu2qSjMRWENGjfdClEbCrLQsu3x8H8lRP+ZVfM=
X-Gm-Gg: AZuq6aLGaLE7XqDx0KuPYwSd+t1U1l4Jmcp56msMnK4WpvXJZW9VLltcOSe6pHxTQQA
	ognhmUYgz+j3OwBhPuSok03F9yB3pS8NRT2NDTNwlgcHzvKUwFSqviJ43ZgOaelQYJIjXvHHkQG
	gMB7WM5U5WScehk2GouvbRwQb91Bl2GZIvvLPXTil5MD5VrvOXES5OJbeK6P9J46mgAg/etDy6g
	5rNe4ej4IulxWS+YGaMTbqPhASO/y03qV2EMtyzpPeAaHjn5VP6fedNGc9Cw7WPlc1Lumld3kjM
	9gYzR8Ry7vWzMIu4OPhIs7QGszVfoveoVBD45ddy2HEKYqwc/DcE86Mdy/ddyBLl9pa3mKJg+WE
	guYREIp3sSIJfC0v6LKrXmsOO5AG1KRBtK4WvCXLgPZ7hR+kaKmG7D+5r1F0fBHvg8/CCW/pcsX
	hkFr2CMeXIq+2l3dVcJjk=
X-Received: by 2002:a05:600c:1d1c:b0:480:3ad0:93c0 with SMTP id 5b1f17b1804b1-48367165abdmr11292935e9.23.1770876947844;
        Wed, 11 Feb 2026 22:15:47 -0800 (PST)
Received: from u94a ([2401:e180:88b2:2f01:9d74:8645:fc44:9410])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaef220cesm3036433fac.9.2026.02.11.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 22:15:46 -0800 (PST)
Date: Thu, 12 Feb 2026 14:15:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: Mainline BPF selftests failure due to rcu_tasks_trace and
 do_filp_open changes
Message-ID: <gcwwc5ezmtvuisrywosgemx3mbbsenlou3k4ytokevbxuczc6n@6pmqhbfj6qns>
References: <djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw>
 <CAADnVQKpvpg+m_XazY8tYyk+aGyw7dJRBB7+zPF8P1HJy78-Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKpvpg+m_XazY8tYyk+aGyw7dJRBB7+zPF8P1HJy78-Fw@mail.gmail.com>

On Tue, Feb 10, 2026 at 01:00:40PM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 9, 2026 at 11:34 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Testing with Linus' tree (4adc13ed7c28), BPF selftests in failing in the
> > following cases across test_progs{,-no_alu32,-cpuv4}:
> >
> > 1. map_kptr: failed to create kprobe 'rcu_tasks_trace_postgp+0x0'
> >
> >    rcu_tasks_trace_postgp() no longer exists with commit c27cea4416a3
> >    ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")[2]
> >
> > 2. test_profiler: failed to create kretprobe 'do_filp_open+0x0'
> >
> >    renamed to do_file_open() in commit 541003b576c3 ("rename
> >    do_filp_open() to do_file_open()")[3]
> >
> > Not familiar with when fix for these are usually done/sent. I suppose
> > after 7.0-rc1?
> 
> These failures are typical for every merge window.
> Since you've discovered them first please send the fixes :)
> Targeting bpf tree...

I overthink it and thought I'll need to wait until rc1 tagged. Glad
target bpf tree is all that's needed. Will try to do so next time :)

Thanks!
