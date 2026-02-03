Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5E2C181
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770091333; cv=none; b=nIVIRhOcSwZOCTl039RTaV3bF2owvdk6szEQTksR/idN+hupOgF8g1vSQySBn5qINnW7ur0Idi7qg/bj7Agqb0DhjYtO7VIHF1XpVEkVCnvHhZnsu2ngGXi4lUEMV9I9vZOj6cMP3JwH6GbYjJgA3c8ImkydWcj5b5LdAIsE+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770091333; c=relaxed/simple;
	bh=mDVFZFVTQdD7h57jKwdjQ9dzOZ2ypDn8nRCHX6v2eps=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XUoa9nxdBpwCnpY00B3jDlMycsGR6h8dvF1atM09i5rU07djDD8sDj/pc8W8COaud1Bb2c3vpN2WbB2CE4U2BEceWtAyn91j3y+80CcG6pNIYqlLOunoJJ+laBK0bfVeeyvuOP3i8lsPOC71QmgRYQ069p3eAQpmp71M45E/leA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=bXr+5+qy; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="bXr+5+qy"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-894a2309a29so4709116d6.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 20:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770091330; x=1770696130; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCClb5NMickaSSc35D++HCwoJmHf50TY9ugMo70JadM=;
        b=bXr+5+qysPaNJ0tsFKnvPQg65Vb3zX8yIHUcYtiyf9aMrh4dNdFySBUSerYVRTb0y8
         nW0c0kSZ9z9Wjc+SiXtOLgqPJ7a2V3+4i6b5k1TQDZThSCcg+XpowsgZ2pOfjDx53BPp
         isX/9O9mAgOCF45EXp+vnjvsr72ggLnI5PqfUvZeOwWI0Z6aNAqB2zbzV/hCFM6ovolx
         gagJ/0niq7+npjvxZ4tFyBN9btbf5AdR2aZsdcSgTdjVdHjmNmF5QLSgcMtbVR865x/W
         vZ+epbKPQdaF9BguI0Wc7zY4gXW80yFE5HWVaAj93HrDZku6US6e5DT+wjzyYrey1VoQ
         35mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770091330; x=1770696130;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCClb5NMickaSSc35D++HCwoJmHf50TY9ugMo70JadM=;
        b=scue8x8lWtOnkFbUutXOCHh6PF9BQ2wYAqNTr2McqSEyrPSHH/RPYKPFkUiktQpwr2
         ajZloGCV57UuDeAsk9AXisxQIA2c1Dq7ayZtZ8KSdP5wfegsOVN4gcygAksibFSb9eAg
         BKfLta7nqRsZkcbam7KlMEIcS1DXlMRcy5MDNXZfudt/LgOWngcpsUMEQk7ng+z6+5H7
         0yHp4pbw35NJkpHRV5U5xg/L2+5MPE34lGi+f5RJwC5ufBxEX/CWi/o79gxpEFTPTY9H
         gIqirpJo7vxnZGSGNIQOCDUA0kysbesCsKJ6fI11TYaPwghBxPkMamzO6DvqLt0XjxB5
         RzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyJ6MIqZaGINpQyvYQ71KToizWYqFYSGDlwkguo7fWzibVlxuWh2ohQ6RuqZtSr/FyBJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlLKbta0hlqc2+2rE8IyqFiVEmOJD+7468iE5xm6x5wnQYD71
	y51egRz5CoTaVkgPlr4pAAwrKm8w6gD/V7HLUgjFaNMJPou1DWAW13Ggz8DXcNa0DpE=
X-Gm-Gg: AZuq6aL6dcY+ziJ2i8SkgpytQoqm+uqom0SvG6dUtJvuI7AJbMA6qiea/vpwzwgOd55
	KCB6W9RZq1kYeFJMnWUJtSsa8sKX2qysMIpnDXJkx+QSdygIgtJ6Rbup/f4Yk17dE+3V8fLcAMD
	koPbgJi/2BrKIUs5/0WYqpP5OxQVrplM7VWwm2qkQmtuW00W46/4UunhPYOtXSrfVXCIDPyQcQe
	4k9YkarTlDytl/6kcUE/kLYEy93pPoidt1xbDvBLOxlGp8Q44zaVaiXELpeZsYJ1KRw07/9uwa3
	4aSI+2Ds8eBrmU6LR2zu+EGt/mUXt8In3YEdNjwkSMOE6bWJwSsgthm4pzqnUO8catoSpeN3AxX
	agCPdB2/CxKlZKOc3wGk/fI3irwaTOJ81UW4FSvhninPGIERQT88XF3Rr1wJkLad2skKRd4vZFD
	knnLdBz6u2hxQ=
X-Received: by 2002:a05:620a:444d:b0:8c5:30df:1f45 with SMTP id af79cd13be357-8ca204a3ecemr213166285a.41.1770091330572;
        Mon, 02 Feb 2026 20:02:10 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d631f3sm1381746685a.53.2026.02.02.20.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 20:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 23:02:09 -0500
Message-Id: <DG510ANGXEZH.BJ9EMMKHP5WT@etsalapatis.com>
Cc: <bot+bpf-ci@kernel.org>, "bpf" <bpf@vger.kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eduard" <eddyz87@gmail.com>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Chris Mason" <clm@meta.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Bump maximum call stack depth to 16
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260202233716.835638-1-emil@etsalapatis.com>
 <e3472b618ca3f4c00a78556992af9c819c3a6c93215358ab2e8d8264a7901e7f@mail.kernel.org> <DG4YI75AFYJQ.FMENV4LELNM4@etsalapatis.com> <CAADnVQKTrozPJ5tAadjQuFjgdOYCaHOrt6vwt5CzNEN1om605g@mail.gmail.com>
In-Reply-To: <CAADnVQKTrozPJ5tAadjQuFjgdOYCaHOrt6vwt5CzNEN1om605g@mail.gmail.com>

On Mon Feb 2, 2026 at 9:33 PM EST, Alexei Starovoitov wrote:
> On Mon, Feb 2, 2026 at 6:04=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> On Mon Feb 2, 2026 at 7:19 PM EST, bot+bpf-ci wrote:
>> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
>> >> index 8355b585cd..9f7fc990f3 100644
>> >> --- a/include/linux/bpf_verifier.h
>> >> +++ b/include/linux/bpf_verifier.h
>> >> @@ -317,25 +317,25 @@ struct bpf_func_state {
>> >>      int allocated_stack;
>> >>  };
>> >>
>> >> -#define MAX_CALL_FRAMES 8
>> >> +#define MAX_CALL_FRAMES 16
>> >
>> > [ ... ]
>> >
>> >> @@ -346,7 +346,7 @@ struct bpf_jmp_history_entry {
>> >>      /* insn idx can't be bigger than 1 million */
>> >>      u32 prev_idx : 20;
>> >>      /* special INSN_F_xxx flags */
>> >> -    u32 flags : 12;
>> >> +    u32 flags : 13;
>> >>      /* additional registers that need precision tracking when this
>> >>       * jump is backtracked, vector of six 10-bit records
>> >>       */
>> >
>> > Was LR_FRAMENO_BITS in kernel/bpf/verifier.c intended to remain at 3 b=
its?
>> >
>> > The linked_regs packing uses LR_FRAMENO_BITS to encode frame numbers:
>> >
>> >     #define LR_FRAMENO_BITS    3
>> >     #define LR_FRAMENO_MASK    ((1ull << LR_FRAMENO_BITS) - 1)
>> >
>> > With MAX_CALL_FRAMES now at 16, frame numbers can be 0-15, but the 3-b=
it
>> > mask (0x7) will truncate frames 8-15:
>> >
>> >     collect_linked_regs():
>> >         for (i =3D vstate->curframe; i >=3D 0; i--)
>> >             __collect_linked_regs(linked_regs, reg, id, i, j, true);
>> >                                                        ^
>> >                                                 frameno can be 0-15
>> >
>> >     linked_regs_unpack():
>> >         e->frameno =3D val & LR_FRAMENO_MASK;
>> >                           ^^^^^^^^^^^^^^^^^
>> >                           mask is 0x7, truncates 8-15
>> >
>> > This means frame 8 becomes 0, frame 9 becomes 1, etc., causing
>> > sync_linked_regs() to update registers in the wrong stack frame during
>> > precision backtracking.
>> >
>> > The comment at linked_regs_pack() still documents "3-bits frameno" whi=
ch
>> > now conflicts with the 16-frame limit.
>> >
>> >
>>
>> The AI is right, we must also adjust the packed linked register masks.
>>
>> This complicates things, we now need 66 bits instead of 60 for the linke=
d
>> registers and cannot typecast the struct linked_reg into a u64 anymore.
>> We need one more byte for this for the linked registers.
>>
>> An option is making a new struct to replace the u64 for linked registers
>> with a buffer of 7 bytes, like so:
>>
>> /* A buffer of 72 bytes to store linked registers in a packed representa=
tion. */
>> struct linked_regs_packed {
>>         u8 data[9];
>> }
>>
>> struct bpf_jmp_history_entry {
>>         u32 idx;
>>         /* insn idx can't be bigger than 1 million */
>>         u32 prev_idx : 20;
>>         /* special INSN_F_xxx flags */
>>         u32 flags : 13;
>>         /* additional registers that need precision tracking when this
>>          * jump is backtracked, vector of six 11-bit records (66 bits).
>>          */
>>         struct linked_regs_packed linked_regs;
>> };
>>
>> This actually brings down the struct's total size down from 24 to 20 byt=
es
>> (tested with gcc 14.2) as the struct does not need to be aligned to an 8=
-byte
>> boundary. It would complicate packing and unpacking the linked registers
>> though, and we'd need to see how the new code affects verification speed=
.
>
> That may be ok, but before digging into it further please collect
> performance numbers for the verifier time and memory consumption
> across all selftest/scx/meta progs.
> struct callchain will double its size and it's hot in liveness analysis.
>
> Instead of bumping the main limit could you introduce
> and bump a new limit for global functions in the call chain.
> I think we can keep 8 for static functions and no data structures
> need to change.
>

Ack, that would solve the issue since most programs what hit call stack
depth limits do so because they heavily use global functions.

> pw-bot: cr

