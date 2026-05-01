Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E41FD4
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777622007; cv=pass; b=CEsxKNh92Ra/ntsc7/IpCcWmIfCX2lNA4dO4dTNjo5MvQXRdufR0h11Hrflh9LvY3yxOMsVvZ8ljJe8iAAsoEgZmWxlr3kWaT8E0vVaPIsMIlnDOROpD+45GOD1unycaH/ZmBE7Afnzvq5bLmlJVlwilbqJUr28/MpsNH+hs6IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777622007; c=relaxed/simple;
	bh=kZ+Fe86L4eg40Yv1e0omdEPVY9hdZBkrNGtDoJCsMLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZ3FvLzBBNFKFlRMTKV/Mm+2+2B/L/tJbwpI1P5lBMY1xwhQ2WjaWfA3yvBHyqMLWuKlVHLbRPFBOsQZZpXZLOKh+cxeZ+2JPpW3Fx4eZz8vMFqL6EjXnQX4GPyRFD0BJ7rxaKPnkh7e7DTFpn2zLsYiSv0qwsGS0nxiRVCq/cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxh8vrIW; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxh8vrIW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f60944so1128603f8f.3
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 00:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777622004; cv=none;
        d=google.com; s=arc-20240605;
        b=MIasEDSfo/2NLPKC1vwR6ssHcOUKIEuhSb401Id2QuRfbR0DOogbQkliz1qh+/WsIh
         Hb09ZIVv2m3Rk7GvQ2n5pY00aJxd5Pur9hTsTlDHOj/dbwSshJ9+JkKXjxozUx6GXjEi
         yztOHaQmoEV2Bf1bsti973AZDRa7S2lhPhBPW9es1y5/pPx3HndciqJRDBS1rxMTcx2m
         QyEcvuEYMeebWRecRtrtzurAjT/5B0PcaXBPUUqJ60bzTHCGc4wG96paO/c5Oy7hW7Dk
         XF+zjUh2bNL90F2PLvOu1bkkJr5Ue4imSZ9C4wFMuDuyhwfDIVdAZ/3X33NcZVViq1nN
         VBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k33OE9cE/aaOG0xCZOkihFCZ44hXEKHH/zGHya7QAW0=;
        fh=BaBjdC2LuLhkWzS5SOF8ju62MTzYk/v3SfK2xAjP1QU=;
        b=UgUDdt0w2ylnwFyIBR5+uSz4ERAyf74didXz2m+MwynrwCMl2cASx7ljYMT56UK7eq
         7QhtpbsMrzlLI8Xqy+aQ+Gf5pDbVPSannpG8+Dx9SXKiHDTvLoB4mEM7BHa+2cFum7wD
         d54VipEvT+vf6RU41JaMOmoJ/pxQOWSzk1VI/Q38WDRpwEC7aZQmGibQa/c28xXB/ZT8
         AktKYeVB6qcaEGA8a+I2Dc9frGYYoQM9Q/FNAbGtI4MXDU2zTOLFX2BCBO2i6AfVT965
         wShs/mUtp6eRVu4Wgs72ap0byxsxuAVH6poJg5RGgjuZfj1FOqWusW/cbzhoImtNOji5
         WvTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777622004; x=1778226804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k33OE9cE/aaOG0xCZOkihFCZ44hXEKHH/zGHya7QAW0=;
        b=rxh8vrIWJbN30BHruGb6WQVCd+SoQudZWEbgf+XMqV/nBVf6YgNBrGKraAysOmfleD
         bTM1OBxQPvA3gPXE7qfdoZy4Aaqs1B1PdE8NCh0vtsjDw31ukDs6qB/bmzgc5zEb6Dhf
         A52bJiVYNBT73DoMdO4AXLLcjqqxQsI0QRSX13FzGG/sNeueAQ+xu3JbfjhcKAd6X9Rw
         SB93in7bTW8hNFZzVK1uvfqAvlxACQughSWOpH33VvNA9mGvPdJCtKXwEBIlERi0AEpv
         0A1nHIMhhjqPQVVmsaMPQSl+mGG5R6Bdv7zVWwZ+jU7psgH++M61Fv+un9p2ir+JNqpR
         8N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777622004; x=1778226804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k33OE9cE/aaOG0xCZOkihFCZ44hXEKHH/zGHya7QAW0=;
        b=KmWpF96PiHVTHN1Z088GfFb7+Pc47WL47NcMx+s6vFiGzFVL9v+dD+fMehHtN1bn4K
         TctYsBmX2C/qHUiWZ0TNFBppAgXSX2oMTPGgPsUHiXPYVX3/JuJsMeQspK7jIE+/+yjM
         fogxbv3CzjUkuuEkSYX2oN5N2ty97Jo2L2h6ZvVqNEGQE2tU1gIEuY2q6p7e5TJIwn1E
         kMKkDnncf8vpkdEmwKaz6gg7VvG+++7QvIVyPByG/WZ1OOMvGLmr5wtpSDBeuLkxXqGi
         ivWZwsy4Gp67sQ/CwK3QEjyIaEghEBiGYuGs+JkvtXbAtAaVEFZCD9rtw4VuWWzYlRxW
         /ErQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xig1XwNY6OMen8POoK/UutchxuAQZuemkc2xJnXW2xSDP+32pb9AXTspgrhbz4ihdVJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6E2q/6b/KM/DWmbgQVgsLjTqT1w7R6CL2SOENLXDgh3H4nKCL
	cP2V3xiCdMdubTK1oG/+wowv5ZnLURiahlZyyLWnivWjO92EAxYyw2X5nu7Hgm9QIGc1Opx4uAB
	MEl6z5fzKrKRauvexek5oJ+E6D/MShGk=
X-Gm-Gg: AeBDiev2QV8gBwYKA1kaQQg5N+JU82RQ9mdnos2VNgCU7/3iVPdT+yXNeKBYa2Gsfc6
	dTxcpExk7z+sV3wxskJJIVbA5sjGKA28AxpAjnxrIQlR9066jQWcH+EqTfV3pMNB7VH8aChY5bG
	3MdszRWxQlUc9o6dHEnrii6H3j0XSvO8alNpIXJNGZdferFcKXsHZfqtj7IJPTtpUlnHt56TCIc
	En16nY0ZU+l9xWeuOOkyIG4xhDwpXGZ2XYv43YS11bgjncyBsi9Xn9j9Q07p18N91b4+gef8fuR
	fax4ou3CWAhgTWJAKRPgQNCTrwgFNquZQrygvrLsjfcQY92jayPN8OjXg2dQdwkfN4XCQd3EnJD
	j5Hs=
X-Received: by 2002:a05:6000:290d:b0:43b:5231:e94a with SMTP id
 ffacd0b85a97d-4493ec61b1dmr10070807f8f.30.1777622003618; Fri, 01 May 2026
 00:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-3-tangyazhou@zju.edu.cn> <518d74d6-7750-4950-a76f-3e67e480840e@huaweicloud.com>
 <6fc310e8-f929-4b1a-b298-71f2445e3c6e@zju.edu.cn> <c801c51e-70d5-4bdd-8f83-d1f71f84186d@kernel.org>
 <e85fa7f9-02ef-42ad-80eb-26c1756737da@zju.edu.cn>
In-Reply-To: <e85fa7f9-02ef-42ad-80eb-26c1756737da@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 May 2026 08:53:11 +0100
X-Gm-Features: AVHnY4L4F5uDmKjqIJ3-QnJcpNYOy7slWl6QGUuFWHkTPuS1A16-aLImymF98wY
Message-ID: <CAADnVQLqpwc2q_Zesgvqq0WLNzcnGUc9D5QTdzLDX8_tj7OBFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: Quentin Monnet <qmo@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 8:36=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn> =
wrote:
>
> Hi Quentin,
>
> Thanks for your reply.
>
> On 4/30/26 23:25, Quentin Monnet wrote:
> > 2026-04-30 23:00 UTC+0800 ~ Yazhou Tang <tangyazhou@zju.edu.cn>
> >> Hi Kuohai,
> >>
> >> Thanks for your review and the Acked-by tag.
> >>
> >> On 4/30/26 11:29, Xu Kuohai wrote:
> >>> On 4/30/2026 1:19 AM, Yazhou Tang wrote:
> >>
> >> [...]
> >>
> >>>> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> >>>> index e3785f9a697d..df43a0e0023f 100644
> >>>> --- a/tools/bpf/bpftool/cfg.c
> >>>> +++ b/tools/bpf/bpftool/cfg.c
> >>>> @@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg,
> >>>> struct bpf_insn *cur,
> >>>>                continue;
> >>>>            if (cur->src_reg !=3D BPF_PSEUDO_CALL)
> >>>>                continue;
> >>>> -        func =3D cfg_append_func(cfg, cur + cur->off + 1);
> >>>> +        func =3D cfg_append_func(cfg, cur + cur->imm + 1);
> >>>
> >>> Do we need to matain backward compatibility with the old bpftool here=
?
> >>> I suspect not, but I'm not entirely sure.
> >>
> >> I agree. Since bpftool is maintained in-tree, it should be enough to j=
ust
> >> keep it in sync with the current kernel tree.
> >
> > Hi, bpftool is also mirrored on GitHub at
> > https://github.com/libbpf/bpftool
> > and many people build it from there, so yes, it should be backward
> > compatible if possible at all.
>
> Thanks for pointing that out. Considering this situation, I will make
> sure to maintain backward compatibility in bpftool.
>
> However, since the xlated format for BPF_PSEUDO_CALL swaps the imm and
> off fields, distinguishing the old format from the new one purely from
> the instruction stream seems a bit tricky. Both fields could technically
> contain small integers.
>
> I'm not very familiar with bpftool. Is there a standard/preferred way
> in bpftool to probe for such kernel behavior changes?
>
> One potential approach could be to load a minimal dummy BPF program with
> a BPF_PSEUDO_CALL instruction, dump its xlated instructions, and check
> whether the kernel stored the offset in imm or off. Finally use this
> boolean result for subsequent bpftool dumps.
>
> Do you have any suggestions on this? Thanks again for the guidance.

There should be no need to do probing in bpftool.
The xlated insns should be translated back to the original format
by the kernel.
