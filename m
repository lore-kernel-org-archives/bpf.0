Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659B30F92D
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869295; cv=pass; b=fVmyGAP1o+f8xGZXNy0GCoPNyee8OPaDG90mbFOuT5GKcnIlkbkpYZ9i8si7ZSbt4VjIrtqCECPHMCyvTKIwFTDSlhFi1nS7mrnnqdhyxrrefPqrp1oQpuirHnEI7ortwXTN/ij5iutrUoEQGWNr+N2nM+ujvoZWnycJwVUp6VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869295; c=relaxed/simple;
	bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyDXJLO3R4Am8/IZpi2ExfGkgm2D1OnzvXJPdPHoEeFIGdBR3qPcHOlqIW3vuXT+aHam4j9HkfQfGVNjcaUxEKh+5zsDtgq0DOGMiqMPkwjGriJ65cY7epZeUCOLwGZobUSq+P7sPAuS9uQKiFH8n1V73FQaer5IKQkgTfcBC1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb1ShRys; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb1ShRys"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-441209fb77eso1347169f8f.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 07:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869292; cv=none;
        d=google.com; s=arc-20240605;
        b=ir/tJrkqm/TFmK0KCeSr4yTNRmldJB4nwubCVnM9IvvZROvTnpvvaG7QnIUnd3z2Rf
         qPOm7GfH76KUI0M2rK/XahSExED9WA2KZnxGFcvBzV7ASqMkVTOjQhq7DC4Dwo+hlNau
         BEIzbDfj3WnH0ydvz9jcNYQvchkBXJnV/c/Lv1Ov/QoSxUyIyJwyxrwhY8OqrprkXoAY
         RL59OeRk5Eml3Qm0UbQkLhxlDLtNQDJeDoaVoZdF45MlzQXytCYt0+HMjjjY9wIRRJu8
         Dlu91k9lXz6osRSbGIA2ZLONGHOT82QScRwc6wsiNJeQid6b1wPXEuZog5rsFdAXMbFJ
         RB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
        fh=dg78twL9218laqEf/oCjNt53/L3I1UuUQlFQEkpMH6M=;
        b=gH2lQsrx3Q6MxOv+iB1LOisKLVychQtnTi3ZfflTYVuEeo2W5nMRLeQ5hy1Rd5QIqL
         D8MxQDPbjVxgvK9At+31DkJtPn+rCm4NK/v8JG7aK5Iphplv4OZ4oa4EJptkZ1FSWANz
         e3txNcpMQOuSty57F4oUcRpjgbbeclgWtBhIja+QX8jrfy8V+UDknn+MtJ971k2wgXxf
         4IJPYuEgZv6ANvdOTJLL8XJwjwWdJdts5ehlt9XndVwB+iwavPjXKuUFg+QNm/h07Lfj
         auA+2va0r8re7dRyFRuKxcbxLFJVL6Jzr0rJ0R37nyofT2BSjYCV7peCJDBON1qwwAHS
         rpOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869292; x=1777474092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
        b=bb1ShRysobJfv/guBXGH2tIQfvbJBdXF37+QGzOj6A0jZcum/r49058R8xu4XpGfk1
         MaxgLaeXFrngS6o48HliqwXVOUOhfWNflD3LXRspe9YhVzxR1AcbKW9pljOMbzeL4yxO
         vLVbWAB+nKgn90E85+kPvheBuhUPnNS2oTeBazDiWElY3wOKGCBl8C/NjbA5FnVcImRO
         RoUGscdYiQR64jcqkyKdaeY0RygSVzEu1xUW5ctXCsgYcHEt1MLusjO+28jwXtpMkMs+
         mf1oIo0UcRoDwuNgfN5Wgclg+XaMwQV5gOTBhEt5DEc1WEh4YdlZQmAbiBRpK+2odnY/
         b2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869292; x=1777474092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfnBijA/tHgHM0lSvhKY7uny8mkDHsaIhjWoI77S9Es=;
        b=CeM3sbxIswMMD6lcNrOqhOgVuVNqwClgXIGpAB9GImuib1A1HAwVFSHpQVwTQo7LZT
         lNHsrp0k9sHgpyJvAaaxiwufAmKbdC3Av4a8c4TX3JIlJJOGjShqow2EkAAO1kfQJKuR
         WQLtko7HqvYEC+fIaOXAnc8VEeIJfYdE7CM8W3DJJ5dGZu/NCZvwdKtNReNT0XUNkiob
         DarZHYqfD9vyYKZ1bbxR1BrfUi7CZceUDvOA/5L6/gMiSkEPkleJFM+Qd5weomiyKyzM
         loTtA0hVNRNgNAlNvntDKzLCrmv6zWEK9V8o+hJuo7kIpO4+kjBqjy0pNOcnt9h/62Gb
         q+sw==
X-Forwarded-Encrypted: i=1; AFNElJ9hJweeYOW8MDICzpknPcdxGllyVtFwqLeVrb+K05afRy9QxJwemzhZ4pSkKvz9fdMPof0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1x6xgfnQyKA7Iya2AlX9no6sdc5CVaHKiU1TCJwwUaiz1uf7n
	XrjnzezXpz4JFUp3geYcEdJCLWIW1dA56LZ/absRtJN9B1MMKU7c4LKWvENw2wQsxVeu1PgoZW/
	j5IobmeVda5YBp75mYGPOtrQQYZkLuS8=
X-Gm-Gg: AeBDietmFicEiliWSWw32Ks7zdlIG43wnyjXU+aHgK5ngXe7ADq5fLOVnRV1YtlUnoJ
	ueP5YqmYxZbe08EtMFa5dlbAgGSE1btnwIsmy/+erIp37+CG3Qn5W3dHPdQi2389O6wpNcrgoZi
	1foXSQcMUwtWqEfMl9sNq8db4mmTZGO9lpkRWlYM9NdnD9k/uO99rCVNgjprHdqjWmhNUsLCTGW
	IF8qVSIp3RRiiGVle++HW/nZWVHOg1UOMWcKtGL/jZHv+e6BbhwYyDoljo9LKzJ+xOG1f19nnXh
	g60l1sBYZ9dODxg1jq77WjrdWw0ZYSqmsKesktyTy8uG9Lhry1x5Kg+oLhg+RbuwSAqyxXWdYfa
	KypOJHRAbsRS55ChAIDK+lNHNSz8zmnTgk8dy
X-Received: by 2002:a05:6000:2dc6:b0:43d:7512:6f7b with SMTP id
 ffacd0b85a97d-43fe3f35785mr36196268f8f.5.1776869291840; Wed, 22 Apr 2026
 07:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acLbnMAPrHCpoIpr@laps> <20260325011853.657295-1-sashal@kernel.org>
 <c7a8310e-501f-48a8-8ad5-0a40d8b3836b@oracle.com>
In-Reply-To: <c7a8310e-501f-48a8-8ad5-0a40d8b3836b@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Apr 2026 07:48:00 -0700
X-Gm-Features: AQROBzA3qHbWnHv7v7Pdc9rqcoF99lBmBFrCQdAyyZbQ78QmK7wYiCIv_i6_yA8
Message-ID: <CAADnVQKshVai_srj_X_T-1AG3QH=VHymDO7Z4JowLcbC+jjReg@mail.gmail.com>
Subject: Re: [RFC] btf: split core BTF parsing out of BPF subsystem into kernel/btf/
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, bpf <bpf@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Gow <davidgow@google.com>, Helge Deller <deller@gmx.de>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-modules@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 3:44=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/03/2026 01:18, Sasha Levin wrote:
> > Move BTF type format parsing and inspection code out of the BPF
> > subsystem into its own kernel/bf/ directory, separating core BTF
> > functionality from BPF-specific extensions.
> >
> > CONFIG_DEBUG_INFO_BTF currently depends on CONFIG_BPF_SYSCALL, which
> > prevents embedded, automotive, and safety-critical environments from
> > using BTF. These platforms often disable BPF for security and size
> > reasons but would benefit from BTF type information for crash
> > diagnostics and debugging.
> >
>
> I had a go at a refactor in this area too, and it's pretty tricky. How ab=
out
> we start with a smaller goal; making /sys/kernel/btf available to userspa=
ce
> on systems without CONFIG_BPF_SYSCALL? This would just involve a small re=
factor
> of the BTF module-related stuff in kernel/bpf/btf.c, moving it to btf_mod=
ule.c
> or similar say. No need to split out BTF parsing APIs from those actively=
 used in
> validating BPF etc, since a non-BPF_SYSCALL system would not need to pars=
e BTF
> in the kernel (just make it available in sysfs.

Small refactor is ok, but in general I'm not interested
in complicating code for systems without CONFIG_BPF_SYSCALL.
