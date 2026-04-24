Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE41A9F90
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009467; cv=pass; b=Cigk7hlRCwIu3LAUI9whX7AdWrHHvkmWgrfIWuiRoo4BZT15DtybBVwNzo3bg9J9Ry8tU9HVNnkPDbHGOq9dV8HWpF1kH7z+gMJpZuYSBhCzudXNv4scFDV4nKJKAL4xHwaFZpRGfZuXC1xEl58x03oyToikpFy5FGVJOomaTzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009467; c=relaxed/simple;
	bh=Me7PVnkzRUpuaMgGPE1fIikIY9kc5geMAE1gyIQR3no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmEGoSbEqeoCFPirN5Z3ec0lBYdmQ5Lqj2rCC2Cyua9aDADe7sw6lMlFxi6aTfMpZWpE31K9cZdVKAoOElV0US/o5z6mqfL/mHVvHkZ4p0yz5lB1SubODxAHBMYwtryWYDZmpQonn/G0ZD6e0kKgk6iErenjuPBoNsfrrV4yzBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA7NYMxA; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA7NYMxA"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6530287803cso7202176d50.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777009465; cv=none;
        d=google.com; s=arc-20240605;
        b=lxwT+hokqP85x9w5C/Ghjccd2wYrxajKz1PizlFBMt4zywVG5LxCvJU6Q1/fxkqxua
         ewYNaP0f7iPD7tmJM7bBrE0a19cdcN9q11Hn8hdCFmjTbWqPxksmh18LDXKCGAXAkQ97
         XFkTsAmv5qEDOWuYZrOxXUEz9IoxsmCcgOgfX5PZ8vhJeP4zfNLfWppXeFwlSAocjqwK
         V27udqXzw3W6WqTOHcbZeWc96fFHQDvA4Jp+0jk/jtTxjM7Kh7bnN7VrrH4RHG8ck7IN
         cOYUS1QAC8PQhfHSo/VLAudTdQBc67nDaXzLk8CqLl8OrzcqdXgKPOrtvvnDheln7Cb4
         S0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ceqdbW/Ut0IoYJeEG5SB9dp/Q2HqRJQ/cXBZaU3ZGNY=;
        fh=38ONQH/E7+12u1vTu+u8mohUqV5BTlQ4f0fXYM20cwQ=;
        b=AW7xbx4BaoG3TTQjvbLiADJKFquF8qBL2Yxe39sga64OQdOYP/vlg00Iv6CIT7SNuF
         3Oop+eEg5oFNlScURVeUjDf8dlJK/+AQrg82pguMso0Rd579SNyPES4rTWya30mFelkJ
         2g2uQhFBJWDca7A6CHvuoHwEq1KursCThbOXAud6os3A8f63JhItKsqP+X9yle+m/bE8
         SBt7ZS9JTHuob+FKrbMAlfr7IYqUrafqaYlCDPquROiNBHAsMHfaT/FO0UWANKSyrXMk
         v/2/SZjhnHY3HKZVnAbm/yittqDkv73lUrfEBZ+bLbukQCMkefJIl7E6Vw4ixWcC7RDi
         MWpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009465; x=1777614265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceqdbW/Ut0IoYJeEG5SB9dp/Q2HqRJQ/cXBZaU3ZGNY=;
        b=PA7NYMxAWUww/37eepXNDGa2uE7SJolndXF3DUgWaKV1BjeZWx1KyzLdIfGDCH6LbF
         d8HeZcBx/wMQVSw8cs2epGgioSPMYABWxuK2LjyfD6e7oq0ChmbNZAeUrAspIsgii3dD
         NOsQ/egCS7B01DnWUorYUdfXZAd2jQLLkJeh4Co1hCX1gsfz2QEWeo0L0K8bnk46K+qr
         VFi17+PQfwZ79kciRY6VS43VXX35Yqf6iKTlrR0FPxoyW78Ns0pM+tfRX3p2hd8YfdcJ
         v+D5tj057e2X/RdF0ivaPqb20DcxNs+KSqMhNknnZEFJuSwmPu/MKOs9v2DXt37ufRjD
         ATUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009465; x=1777614265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ceqdbW/Ut0IoYJeEG5SB9dp/Q2HqRJQ/cXBZaU3ZGNY=;
        b=Jep/HNY9XYMqXvWvPep1FdJIOOoNWaGfcpK44W4If56odyPFmajtqxUWMUzTO8+ofy
         R7swTi8XMtrSW5UO+hfifS7D7gLH9Omii6li/SJFR9i8fJS4Tu2YZp5FB/7H7o/Mo1AS
         IqLLS6Mh7JalMepruzs5h1wm8nzCLfihq5GXShGj3Qo7btqm4dB8o2f3pbQQrN6+RrOo
         g37tAzsoI8fDPO7d2SLipCJWtWZ7cF3B9AfRwqTCehRdy3dn2bwVvGBdwIzv4q4lQK+F
         1YnO0VgL9IKExDyyOICrs0Hbxwrr9dPQQxMGB6T+Mf54BYvNYaZSFca5s/Iu8PEnUdC7
         e1uA==
X-Gm-Message-State: AOJu0YxYRjkRf9jivsd3DQI//3S7KBztHcp4z6ZusP57iCTuC+1OdB2i
	F1EklNkpBo3E68yJJGCP/yD+FOLFwHqBH0thRWp4zIDSEdE0Swj1MJbRRbPSWJ/7pJCum2e/GP1
	3auU0c42gFpDVtSsBS5pXiwSk/iKJx4Y=
X-Gm-Gg: AeBDievDybQpl03oNX4iJhzMAyCUadJLFoKMAmmYBN1aQnLnIhnYTN50rx83mXqZSj2
	JfTYpGuknFxTV+kuy4hUorcVfpJXjZEG0VwK6QsigoMh9AQo8FpfTGkdbnrjxAztf0obMOwL/qu
	voWsB41wq9Aw9ealU45ibvTw0Pcvtm8szQmUNIHsPiN3XF0ZieqEQQOqcIAo8XDcyr44HAoXG7z
	DRL8lgGpIw1Zq/wjJUBOzpO/Vo8hujJMCIjnTxMbBBo6Buq+wz+t/tur1Q3teTgGMI7bpt0YdI7
	uyXP1jicX8HPgkpvwQ==
X-Received: by 2002:a05:690c:3482:b0:7ba:ded4:df58 with SMTP id
 00721157ae682-7baded4e83cmr256598867b3.49.1777009464910; Thu, 23 Apr 2026
 22:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
In-Reply-To: <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 22:44:14 -0700
X-Gm-Features: AQROBzDvPO80brxTqh36WjUyhCJaCY53u6TVux_Thos3y4ABLNBHhCXV1MZzfE8
Message-ID: <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship tracking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 5:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
> >
> > (3) Referenced dynptr with referenced parent:
> >
> >                      file (1,1,0)
> >                            ^ ^
> >      bpf_dynptr_from_file  | +-------------------------------+
> >                            |       bpf_dynptr_clone(A, C)    |
> >              dynptr A (2,3,1)                  dynptr C (4,3,1)
> >                          ^                                 ^
> >                          |                                 |
> >                          dynptr A and C have the same lifetime
>
> If I understand the proposal correctly above should be:
>
>                      file (1,0,0)
>                            ^
>      bpf_dynptr_from_file  +-------------------------------+
>
> ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
> but original file->ref_obj_id will be zero.
>
> ?

This is the existing behavior. bpf_get_task_exe_file() is tagged with
(KF_ACQUIRE | KF_RET_NULL). Therefore, file will have id and
ref_obj_id both initialized to the same value. Here is the
corresponding verifier code:

if (is_kfunc_acquire(&meta)) {
        int id =3D acquire_reference(env, insn_idx);

        if (id < 0)
                return id;
        if (is_kfunc_ret_null(&meta))
                regs[BPF_REG_0].id =3D id;
        regs[BPF_REG_0].ref_obj_id =3D id;
