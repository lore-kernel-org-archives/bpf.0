Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4C54BEF
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781461; cv=none; b=h+fw1xD9t/Evs8gp8BnjtJ6HgRWyblhYU/CxCacdfwgmjPCN4nwNnodDU66zlgdJGftuUQ5WBtyh0X/yWam0/v9XSu7KGyWDTLoceFv/0f1exobEIGwoTDkOzCnKsPW9QL/KD9l7pRL3OLpaopFGG75ibp1NwQNOGheG7KxtomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781461; c=relaxed/simple;
	bh=8ftiFL0GQGicYqqpfe66Cj0Pr/BLiTXq9j7/HkQq9cM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DLl7tEC4bKwccX6wSlNNPBaNAdgF/R6KZl0KoTw8SWz1Bo3Cb7IZCGzj2Cp2R+Kn+UrytSkDLNKaqgHVkeC62KgnWgs2TVVd7yCfAUjlMrfgjq6o1PmLv/dungTU+C6xEM5DTDOtSUv4tSSDoveqBmOVxvk6N3mAhZO7Ut6H4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OGd/VERU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OGd/VERU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dddaa02d22so22736465ad.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710781459; x=1711386259; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LrM3zRjiUPOIl9FUgpxwfnBfX+ju32Grg8pPTlJ3V1k=;
        b=OGd/VERUrZi8v4+L1q6YY4/N64R3EgWpYb5HY2Z8grgIfqdIO5ktRWMf1nZe6mDqyy
         khTPwCDMloByssvobiBSlKu4ecqEjGzaVbHokIhRtR4iCysX6QIOlM/HRe9DmpKJ1ggk
         ALh35OHXkplXCpX79dnAMUdJAU/Hl9NGIo8Z/KFWh5sdW2RoKpHEsLAoNXGTOurme7h4
         4CfWDTX6EvCVoi89ZRwYXkAvemqLU+dAfzuAfhUN5OqP2y1byM8c2lCp64qQtq9Jwkf6
         WvNSWuGoPCn/DlcJZ7yRHmSJHMahg0p1Cc7n3e+NVyjzMYeuH2iNm2xdH/Mvj1ULkqRe
         cg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781459; x=1711386259;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrM3zRjiUPOIl9FUgpxwfnBfX+ju32Grg8pPTlJ3V1k=;
        b=xD1zbjCCBzY45cmRwXK+JMJ/RMHwcbU8v7Du62oN4X+qs5q16YhflAzV3xFiHxlUUc
         2a+3wMEaLWqCHZ+GT9VLrps04U0So8BCZBzLTenNAsi/vdLb9NhZ4xCfndevzUxZNGc2
         zJ8xSBPogR2w3kUVcSeH/dEXcaED61BFoGVF0cGfZOypPOUzmaNIytvV2+y0hPSh3B2w
         Mgktgny6RKQ01HcKQox/cT5fpG58p8E32feChPV5e4+LBwr+TbQIzfgM9PNG375qz902
         bGCQ9RKyzkXWF39agYRA6tI5DhphOp38uDyJrW16mcQabHyr4KZSa1GZUFdlAIMFOSzc
         0seA==
X-Forwarded-Encrypted: i=1; AJvYcCX50kVlFKYULXNJUP8C6aoWlt/0NibeEI1Ev5zXwMo0GFi2j4iARmQOnrl6tOxFoeOGbAm+90GaaRSKqV9b5t97SLaj
X-Gm-Message-State: AOJu0YwLh53xm6YZzVBjh94gibqZHM0gUStEeH0oOa/hhak73vmOINl0
	tKk/Xccgl2Q6O8LTgyEcOenZvewScGOH3QCv2Tj1HGA02lF/FB5oUeGb82LcFjI=
X-Google-Smtp-Source: AGHT+IERYA2e8cxn/sdcRgD8RacyR6226Mt/AXRC//iAAiOpFDkWzV/PgNBiViS4o5lLi7JQSI9x9g==
X-Received: by 2002:a17:903:264e:b0:1dd:e13d:6834 with SMTP id je14-20020a170903264e00b001dde13d6834mr9347172plb.41.1710781459129;
        Mon, 18 Mar 2024 10:04:19 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001dd4fabf695sm9507005plh.38.2024.03.18.10.04.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2024 10:04:18 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Subject: ISA: "code pointer"/"address" clarity
Date: Mon, 18 Mar 2024 10:04:15 -0700
Message-ID: <0abe01da7956$4f526840$edf738c0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adp5ViPBDp9Ecir+Tt2UygEkUQtvhQ==
Content-Language: en-us

I have a slide about the following question at the end of the ISA
presentation
at IETF later today, so putting it on the list in case there are any
comments before
the meeting.

The jump instruction section defines CALL with src_reg = 0 as
"call helper function by address", with
> Historically, each helper function was identified by an address encoded in
the
> imm field. The available helper functions may differ for each program
type,
> but address values are unique across all program types.

First, this text is slightly confusing since imm is only 32-bits whereas the
document
never states the size of a memory pointers in the BPF VM.  One
interpretation is
that ALL pointers are 32-bits, and another interpretation is that the
pointer size
is up to the runtime, but one can only use the CALL instruction with larger
pointers
if the upper bits are zero so that all non-zero bits fit in imm.  It would
be helpful to
clarify either way.

The 64-bit immediate instructions section then says:

> src_reg	pseudocode		imm type	dst type
> 0x4		dst = code_addr(imm)	integer		code pointer

The use of "code pointer" rather than "code address" in the table above
to some readers may beg the question of whether a "code pointer" and an
"address" as used with the CALL instruction are the same or different.

It then goes on to say:
> code_addr(imm) gets the address of the instruction at a specified relative
offset
> in number of (64-bit) instructions

Which uses "address of the instruction", and that sounds synonymous with
"code pointer" so the reader wonders why the same term isn't used.

Is there a better way to clarify in the text what the intent is, either by
using the
same term in the table ("code address"?) or by distinguishing the
definitions
if they are different concepts?

I know in Linux the "address" of a helper function is internally implemented
as an index, but that could just be an implementation detail not worth
mentioning in the standard.

Although detailed discussion may be in a different document (e.g., the
"[PS] cross-platform helper functions" document mentioned in the charter,
or an ABI document) I'm wondering if there's some trivial wording
Improvement that should be made in the ISA draft.

Dave

