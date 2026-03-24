Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDE4035BA
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364625; cv=pass; b=S2tnu3qD0DCE5qJS9MNdds5doROPckMD0H1ByfyDsBdkGy58kDKC/+Uii0xhCmUbjgY34OvYKzT3V0TIDCQb0GH/+Z4PE2wo8t551/lBH2KlFoKaEGZoK1vA0t7EkNvxspiJu6EL3iNz52++EIvmVxKUVfBjlaHZXljdBu3v+Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364625; c=relaxed/simple;
	bh=pGbN+jWmTUnUhmVdSv4PjGYUGPR4AJuGRrmDZfe9TOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hg2NwJWeMyOsaLAMwZJbdgjVPp/+nwVTRdH7SJutdEUprmFE0dkhnsY0SoGQMuclcXor3/910ZdazuRfW1iN9TJ+Hrh3XZ8FwwXWMLsbmibxZMPF7KzRy7s8PtsYq6xIv1JJZ3MfUAd6zfLsBD8qKUDyKANSH0d05uLhtd+sx5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siUVWbSY; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siUVWbSY"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1407395f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364622; cv=none;
        d=google.com; s=arc-20240605;
        b=PXXbT106MZ7Mxbk+fYw6bbtkTiGMzYirh1iTW90StO/mVBp2ulKDLEPXzQgnm7B85Z
         h5Scy1hTX4Z6i24pgz3EF9u+n0E3B3FQHbRTgbV03ExJeIVTsWUxc6YMoreN+3ZG//MB
         fPUg4X1HNHNBPQuXckMx4KbGYMwBbXyvqCLznnrWTp3dVuvcGLpxl8Dhy4Ahs77D63Dy
         0U78WF8MjSrxcX5sduIHG6Vxg+9fq3mXOroL51xk3lwculZCp+8h9NXOm96v5LI3nkDr
         6u7FvxEo/KNz5hgvfzSu4LMSxrYpqf0Wdjj/bJBZYplpGNCdugjEK3mq42XamaC+qxf7
         CkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7pygaIxmYy8vrcTultPBr5yJtweQmbJOPxaBB0Dq1tM=;
        fh=RFu1UvqFHNwAjs938qF5ngJyrku10ZZuwNWRlfWawRs=;
        b=gahYy9k3btCUdGLjEgdN7VwYbahiH3JbxPjIeKWRZ4OkipKDlm/Pl2TpyRBCxJtp62
         W/jLrZr9hWkWejVWzdc6of4udV49oGfAY3rhgVUySBHaCV2CcWpGbtG5/LqBCzpplva/
         Ts2yxOjMmSj4Rmn0GcRSNzE0biTK3OnGgdWXIcofvMQy/PZNJEFp1BMxTSXPtrr/15TB
         aoQj3ln3PXwJVUoHeeRu9e8FPLhAUd0O9zH+11zWpx7Q5lYxQTcv2a4aAbLEgWlrbHwL
         G8CApHhq+WQXIUukAGzLKGzNwqac/lIGl5Gyaza0ti0xLMJo6F0b0LsIkxLV2ncpn9mr
         QzXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364622; x=1774969422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pygaIxmYy8vrcTultPBr5yJtweQmbJOPxaBB0Dq1tM=;
        b=siUVWbSYsavvuxYNjP/noYbF2sxVqbJG6PaAsB9okjKvG4Aw9y6LDOLp5hiqMfM5ke
         tD7QxgOChmurznz/jclKWPLualaCjOt5+yIbyBsTzQrH8ogjBbxzmJa5C8IqbKDGzY+0
         N+rxbhTOA+aJX1jJnKSgnOpsxYDj//mNeWklMxXUWL2ohm/SMETvB9MkMIxLq+Ea+jwX
         zv6TnqozUCoU6aT8Fks/btbFo1BwM1nnYq8JI50vzsGEvC3hFeDGsq6VNFp/iYvbmVmf
         bS/6Yx1EwlafiRevKRIo34SPtKeyi5qBkiydVySWmV8KG+ynX0l7s0PnX6AY63fMduCQ
         mUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364622; x=1774969422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7pygaIxmYy8vrcTultPBr5yJtweQmbJOPxaBB0Dq1tM=;
        b=M0ZcrXOxhjuqXCEVhkauyhlu2XL4t64OM0QLV57vWiMqx4MJHw3aai/j6t3j/sAHAQ
         p7hUjieMxMFpZEO+kAR1Nw66nT1fTOd2lTCJg73HWnf3W6uJS8+mLnOTZYHWQ1MNiAdX
         6EKPaxGm9WhDGtu2Aj2H5W7EZhO0kWvEopkUEQ9jI5IcdqA0/H0guWJP+0wis3yjMIJV
         xFjyyKp95poo4HOoUJPszqoMXLuEAdHEluI0A5iSz5XPxXDvADxLN2m7KlBg3HZPES63
         CSsU2MatLZFf+DHi2hgg7wLIEOKTNRdhu+aEgemb2AkIADAoeoSAs1rlBVEVu1UVctAb
         +bpg==
X-Forwarded-Encrypted: i=1; AJvYcCWcoRaDxDXSwcIwOMRrdED0IyUo3iMBl46Yhtrml6xdybCE752o/sw7Hr1U8PnX7CnMgoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTOe57WJnTAi/mOXOqv9u+xIIfQYQe4jS7JeUbhFTgsbbpA+q
	6AFE2TV6zhG6gIVONqTpkNaX+LCfIDQ1w4sDcfGRqmarUupS/FFtL9z23YaHjgmIi7k1c9dF2i5
	vFfTHSuHP8+I2ApzDk918SwNFdoKUaqY=
X-Gm-Gg: ATEYQzzolb0cmFXLekBlXxqf9iagovOzNRNnlvHHVvxoAUm1FxLQQ8rY2scMqtNKI17
	Koq4QgrGZW1AH8rgpI/lNHJkLgOZc6TLx0aAyFhDwVcXKxCiWTPYnglAWbcrqlSXiwWJzek7bDj
	9e8zJogR79XXBwPqJ+Gxcil3S4/rC+54LzPtjCarsNhw6yMMGaikhCPQA6jiM+CIkANq/g7HJU4
	TxwCggQOVMo6lLwZp+0JyWLgvVy2Ew0P1D4rnRoQ7lJv7P6miQZd8UFMLP4JE6r0UIhkNGmWNDs
	iLT34QjmjNE1cxKxO2eKp1yKVotFXhVcQgTViB5pXcq43tUQf5dd1DfCdLglcCPrqH02j6jDZIq
	0Rt9xJkNjrONLayN5BoalWX48cg==
X-Received: by 2002:a05:6000:420e:b0:43b:5231:e94a with SMTP id
 ffacd0b85a97d-43b6426580dmr25272373f8f.30.1774364621590; Tue, 24 Mar 2026
 08:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323164858.1939248-1-sashal@kernel.org> <20260323164858.1939248-2-sashal@kernel.org>
In-Reply-To: <20260323164858.1939248-2-sashal@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:03:30 -0700
X-Gm-Features: AQROBzBtYHLNynVUYaVr0FFPgK1a9gR9szjQmqF2fXdYPXYOTswB5hwZbCigrcE
Message-ID: <CAADnVQJjJwRtUQNZAhLoXF7DYprhU97xJReZg9izV7n3f7=uJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: show function parameter info in oops/WARN dumps
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Juergen Gross <jgross@suse.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Embed DWARF-derived function parameter name and type information in the
> kernel image so that oops and WARN dumps display the crashing function's
> register-passed arguments with their names, types, and values.
>
> A new build-time tool (scripts/gen_paraminfo.c) parses DW_TAG_subprogram
> and DW_TAG_formal_parameter entries from DWARF .debug_info, extracting
> parameter names and human-readable type strings. The resulting tables are
> stored in .rodata using the same two-phase link approach as lineinfo.
>
> At runtime, kallsyms_show_paraminfo() performs a binary search on the
> paraminfo tables, maps parameters to x86-64 calling convention registers
> (RDI, RSI, RDX, RCX, R8, R9), and prints each parameter's name, type,
> and value from pt_regs. If a parameter value matches the page fault
> address (CR2), it is highlighted with "<-- fault address".
>
> Integration at show_regs() means this works for both oops and WARN()
> automatically, since both paths provide full pt_regs at the exception
> point.
>
> Example output:
>
>   Function parameters (ext4_readdir):
>     file     (struct file *)         =3D 0xffff888123456000
>     ctx      (struct dir_context *)  =3D 0x0000000000001234  <-- fault ad=
dress
>
> Gated behind CONFIG_KALLSYMS_PARAMINFO (depends on CONFIG_KALLSYMS_LINEIN=
FO).
> Adds approximately 1-2 MB to the kernel image for ~58K functions.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Nack.

You asked claude to reinvent pahole and BTF and it did it
completely missing years of fine tuning that pahole does.
dwarf cannot be trusted as-is. pahole converts it carefully
by analyzing optimized out arguments and dropping signatures
from BTF that are not accurate. This work is still ongoing.
For example see this set:
https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.de=
v/
pahole isn't perfect, but what you attempted to do here
is just broken.
