Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A517352C5B
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080357; cv=none; b=Z11LxNOTL4xmtZa2nCzCu9ctpm3Qxe7fWEaNXTwTqbfe6x2TR0/pJ6s5IlioiIbfetK2tTfnLXdVjQ8VZjXoRHoXG7S60Wfd04OZTzm2cIRs7ujE8xw23BYjYOdU0jRwNMGlSIJQHEqsKZvzCP6YMcATnnRreSv75R+nAFpedHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080357; c=relaxed/simple;
	bh=2xLv+lkW8pU5VA7oO1sqLOAY8/n80WhzRp+T01m0su0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyjR5OBeUGBvypcQhGmtg6zA4ck0EEMixR+4i841XAFiSCetB/oHVnN5+fcSKEY6a6T3AqONlk5QWynzS/Dk0TxoqUfNbiwYBwWlgRtFDePSfn9UuXEoc8nUXd9SksH+wQtuz1tVUIxHqILhBPN6zBdC+NHrEOLWqWllXj7I2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIR0Nc61; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIR0Nc61"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso655ad.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 21:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080355; x=1779685155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHHMa+s/OAm35YOgp5jbZd1gE08UoFSJ+C54ztSuSLo=;
        b=bIR0Nc61torwUpGA2qBA5XDnDSCeLS0RedAT8wNwA843ZVsO0FY23Bg80Ugkv2iHLC
         VP/MNlKZTT6rFiF0mEX6BTFDyIIr2bJBM1m2iR/eDpro550aerCGpWb434h/EGIJbpqK
         5U97JxUZBP7l9p6j/G/EzYCYdiqfUN2r69F49LfcfVgdWCICnN0WlT3e3CjUyHPg0YcA
         UJno+kY0PWZjdMAGBE5WEPexVoEJYEGWF3APGwIP3wC9vuAep8Zp8t5oQE9XN8HDJf42
         FZIsUIJbOuC5cxZqlucJi6jG1WWf3miKRPSIQrNSZxdVlxX2lxJt92pWznLVuHyZX9z4
         cYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080355; x=1779685155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHHMa+s/OAm35YOgp5jbZd1gE08UoFSJ+C54ztSuSLo=;
        b=IPqBwsAA6xQmBmK0j+HnIIv/TvfYb4rViXirPLlGMx1jByLIjTOOiUqp5FPzNBIUrs
         NuubkEMR5whQBBzZ3abRKRuXh9t+C8qhyBuTOgJnm4XKbVuQp1BFf4kwCCEVYa48Yypg
         hgfnMvgL15zV3NDm1lettLWKNUobpkhHZWfiNg0FnISbtI3gblGQd41MiMzKLp2X5Ore
         pjasxzsNrRUjrsFfP+qJOBwlBuXoO4hLeiK+Ot+7/C3qx1qEORun7sF8mXinH2ZzEYcv
         ycfPQ8GaInlcR1ceIX0knX5HK1nvGXMTEnd6tucrt7iBhuyq3bEsoLs0e89bw6KoGl3s
         CFeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UCUldqFFwZNR6JFVoHUqlSrOjKK3HfRQJmW1PbZhE4Yl5MDgcH7mdAvy+Rie81dwq6aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0PUQ5C876N5wywiMKHdFrXYpEW96sjFjiaRAisUmNWsUldr6y
	+NH9XqKHtqI2T5FezF2gQMdSW5w+fI6nmp6xUhWoNHLwQLeVXInsgQmQN16YeW81NA==
X-Gm-Gg: Acq92OEoKzgbxVOjiZ91GV4gCp7qpInxh8cvIQpEvdmEehrfZiGA+n0c3d80ENC3iEy
	P78aRRuZ0IY0rEqXwG9Q9Ka7nX+aYRx2AVfsE1jx6q89LUo7dd+bh0HxFK2xtqlKE7nhPDiPK8B
	KLnMbWgweSTw8eap+pbo5b9+n1BvlYlbGTx1Ia+FdzkSNJAQVKWFcfzA+ToVF+/3fHxx2LQnPuX
	wYVoLlIsMrfILRXJXcl47B9cBCY2V9ED+thd+7IAWO2LbOwoJZUlpMwHF2Xba5ISBGC0TrOd5vr
	ct17lSfN9C7C3l/XV4QwIjZCPHpc4yvdtWwCjTkJKKg4RTks5Ck0njSAKFKLX1htii8ZBHkhopq
	Qwsv2q57LSA4W4dD/D5BLxn5kgZ4K3gFJg3ACygQpExDUgP1FIsbgo/OdDSLU9DXgMsWjy3qSLA
	jFo++L5Np3b/+h9YKUdHkKn0v/8OrKAew4EsMN4mSXjpiOmkchsnCGzkQMi48go+wyHY9mLQHTJ
	KikjVZQjEkcQOuBN1BxJayA+7El4VhLQo6OsNZxKnqENIKJXS5q5pzvwQ3lfSd+wmo=
X-Received: by 2002:a17:902:ce85:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2bdb32bcb70mr1893025ad.19.1779080354646;
        Sun, 17 May 2026 21:59:14 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82e7ff304asm2871640a12.12.2026.05.17.21.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 21:59:13 -0700 (PDT)
Date: Mon, 18 May 2026 04:59:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mykyta.yatsenko5@gmail.com, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>,
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2] libbpf: fix UAF in strset__add_str()
Message-ID: <agqcnt81eI16gOYr@google.com>
References: <89d34016-cf82-4beb-989c-e4fc2e3cd29e@gmail.com>
 <20260515044759.2863546-1-cmllamas@google.com>
 <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>

On Fri, May 15, 2026 at 03:08:47PM -0700, Andrii Nakryiko wrote:
> I agree that this is a usability problem, but I'd handle it by
> recalculating s pointer to correct one if it happens to be coming from
> invalidated strs_data. Something along the lines of:
> 
> const char *old_data = set->strs_data;
> size_t old_data_len = set->strs_data_len;
> 
> p = strset_add_str_mem(...);
> if (!p)
>     return -ENOMEM;
> 
> if (p != old_data && s >= old_data && s < old_data + old_data_len)
>     s = p + (s - old_data);
> 
> 
> At this point s will be correct even if it was invalidated.
> 
> pw-bot: cr

Oh right, that totally works. I've tested the changes and will send a
new patch. Obviously 'p' was meant to be 'set->strs_data' in the check.

Thanks,
--
Carlos Llamas
