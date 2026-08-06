Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB841F427C
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052716; cv=pass; b=WkwQcaxKUtMCO8yImsMemFc2wkv0m57Zx/XyYKhEJp/pntIcy4ssYdBjbxgExzgju0z/qgNK/CVQZvC0uI8mtnMr+OABdoNzZu75zqv4lJxQJW4MGk/VZFuEOpm/DjbUDqMEN8yxSzo23MwU5YcZlTLyBcGpgk1K7T6fWPZCNzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052716; c=relaxed/simple;
	bh=PK328fsXxrnSfxwWxbhaOTBsxDsbWAQZmZRHgDGiP+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV7Oku3Uxp6FhO+H593a07stxYtVncunPDNYcRmCW0YaigA0nmZ7GaS12fHwhOoPq1NjnBXdfyMu4Mgvq6QvPdop5hfZej6Wcm/QsEvS4EtNuQ0YQW/hh9Ewz83u962A4+H/gc3e/ReP/8oZ6Hfm9/HHN0ptnKzYRAqSiJDV0W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OUEVn1af; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=alxYbj9m; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OUEVn1af";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="alxYbj9m"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676LF36u4162547
	for <bpf@vger.kernel.org>; Thu, 6 Aug 2026 21:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=; b=OUEV
	n1afqfcYalp/dvkYGJtHNlajXOIIRfYZLt5YedM1CA6PJ1yxajN8vAxR9p9++GqR
	QOkueM3WMr6/5NUJuk7BCpttIkMW3qrzMWFgvQQygnBixEshBrGxw35kUN/ZUXaY
	Suieuioj7Rv4mZrQUn0Zg5+EB456OxQtxrAr/lGzxg77qpo3IG9TpLIa+/xZKH98
	ZnDbA/eLx2bHZ3TBVAkYiOEQtiWMvGHuFiHUhErdbIeLszHPYuefaQc+U7Jos09i
	0EBxPD+xQk9GZwpI75tnme4N4WVD4X1ed3Fr8kjqEXEF8VrQvnqXJBqaH9lwyxJw
	0a3TvZ0w+8IGNShi7w==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fvq5kbsx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 21:45:14 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-668910ff32bso5060226d50.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786052713; cv=none;
        d=google.com; s=arc-20260327;
        b=ZEINaT49MvIyzem0GNjf4Yrfmuat7TeBmW4VRG1E7BVYJQAJFMiTHFwfeI6IHNNeL9
         VNy7UJyQZp0N4S+rdlwRABOhSSqUJTTAxaXf0wnypaVTM5yzKC+w8YdQ328Y/yKTpitR
         LZpAPh+XAkRDdu8uwZpicCLo5G5zXlrI1izzcUrPx6PIOkpS6/bcnig/XGkJ4RwXprrD
         e4sdqCeLOOwPxIUOZCCY2cRScRSgvdsvyVZMJRLhzpznAcJ9r274mLJF8shUSpDCNQiM
         RRkEsFxeSTW1p5aDXImhOy5lDryzj2s+r4AtAwEe7dDJDbdV4aaF5CfqfDbvmNS8ll6x
         DFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        fh=qzJF9JYLg1VmRR/RNVZv0MwArlSiVOQnK5CJDttAAlE=;
        b=kG62RjnapYr1GsaVugr7L+sr7VLbKwFH2JZv3GUemU1ZDoQ4dnJcdEV/8ZXY7ogZMS
         qDGWnQAbqBWsiaR4JSirVvEE+loROjIpUFEhSTEo1PrFgonl3o7kZBH8042ZisZDLLny
         KXmtHnSvXG5/i1GECsUoyk1b/mweAG4kQZlMcsaR8puqPqYdLn38Jt2FMCJRCR77h1pO
         xG3Xxj/VVB3RY5aO4qObBx1YyFoACvSQd4EQIOecQf5Sj70RFtc0ZhLpXiSdHKjIvPMJ
         tClSP8KAQYeP+uQ/lMz+7kh6XBHMTLf4B18DaIPxaXOMzAyWMbKIw6m4nRyItTwwdMk2
         5rxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786052713; x=1786657513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        b=alxYbj9mK+s/YyRrr/7GTyGfvDNkPGzAGKItaVc6sel7LSOdSEUmUSaYICAdDKm0YP
         PF1AI1Fn9vzJSgkwzzdEyTNvrFQ7SrYvsIZR2d4utplAeKKUy4Qc8Kwwwvn/HJU2MeqJ
         L1bR+b93ikkaYCQj/JaYEWmZaJWxC05Xe9tu/InspoVwGlectf4z3QEnxvynmAGblwQ/
         Qvti2AeY/6Q5F7IEA70XNrNMfKxFXE/GG7ClrMy9pkGx+IpVpxgOC9/yxucj9b1iyp+e
         267L5PGPlNuz0gLy7xr9/k+x+uEvGveKDZWjRhbHaym1ITdzFl0+58KhW5BDKP7zpxtP
         uDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052713; x=1786657513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        b=esoqgK7d/htQXVvcS6IR/rTH/5NsuKKH+k6p24sSFrQ002c4UE7CiXryNfH1JF+axy
         RkdVyCHLGgGP96ZDzTIsg2gUxlJabw1ICbmCsqoj4NLBqVN7MvDozIEk+kX5tGg7G6Q2
         9ophwJI5far74KPm5sufUZZdyWnlQ1FRf47Dm+m8T9ustoJXaC/yWexaD1PKbhINUK/q
         Vv4cZW/rUfa/OAQR6NHJhovNseHCEpdOahPuclIiXo0n0fqk3OId5TnbMY8+oaoRvoBE
         9Vm+f6SJuAMPy6fKBWEct5lwiFZwRfxrIHfxH3h0x5O4kuMrrUrzgNQWKvHMMR7m/qXu
         cPAw==
X-Gm-Message-State: AOJu0YydeNK15aDQcMlFsQKp9yybLJGMer/Jg+IyBLIVZmqi9Cb3A3dF
	8XyKF1Q4i5e6XC+8rnjI89KBNqqvutMdf6WmEbceurKw45Txmx+ErmN6Wyi3P7n81kmluGt2jGN
	2bm89XKrxHdNJCtFWwszqYZ0jgJPjroJQAQlYVT4Z1vERVyXULsl3e2bQ27PtK6dTEI7b1EkLwv
	0OcQy76/wc0IUc9xbTXIcDO4cFHG58
X-Gm-Gg: AR+sD13l8sJ60D5L7bdNwmMf9gAuyJoJSYOZhpmt/qyD6p1a1wAoBUnyS9QKuiQSrl9
	mjO7XT6fCZlr7uWcUj5ukyMJKIdJsd230faHCw20TGdHlc7XeWpgvH8X0v2GKGHGNY8KfSc7rX5
	VDTAVwA0Ifz1KgFJSW5IkymSpqGKNSfXOxkbr/VwrbPJmPrfuqoz+Vy4JsrQ==
X-Received: by 2002:a05:690e:b87:b0:66a:c376:6f86 with SMTP id 956f58d0204a3-66ac37673bfmr2597588d50.8.1786052713178;
        Thu, 06 Aug 2026 14:45:13 -0700 (PDT)
X-Received: by 2002:a05:690e:b87:b0:66a:c376:6f86 with SMTP id
 956f58d0204a3-66ac37673bfmr2597553d50.8.1786052712556; Thu, 06 Aug 2026
 14:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com> <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
In-Reply-To: <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 17:45:00 -0400
X-Gm-Features: AUfX_mycxuhE9bBXZ11D4K5vINcCDSJcPpDp_7gksuopKRHXb_3yuGXJfDBYFSA
Message-ID: <CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
        jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3MCBTYWx0ZWRfX9lIoxL2zyRUs
 AkZiEp0uIjJ5IIU03UZgFPb8mbnh3cniPmh0mJx53NXEux3VfpRu6jdFBn5ZANiRA9XSeB6UcEq
 /CSYnyTvzO3zuLRMqBipFDFlIqlvf7NWxCZ9FPVg4JORCAdQ2ajw
X-Proofpoint-ORIG-GUID: aPe3lg0cwJYE8Duslnrm1zRhApu-6Yce
X-Authority-Analysis: v=2.4 cv=QfJWeMbv c=1 sm=1 tr=0 ts=6a75006a cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=ngmC-yC5AAAA:8 a=e25ExAebAAAA:8 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8 a=dDW-ktzWsA5qhXuJ1JwA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22 a=P5XVh-r7Nk77isVNjX_M:22
 a=Fx-rEtueDibNKiZPBj-h:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3MCBTYWx0ZWRfX5UDHr4GYiNFI
 T3rGOFqqfuZWI+GuLhn53h2ZJD4bOoZ8tubMr/bOUYW1Q9sQVyeZLTDMXVFQ5qynnwIJ7ppl0SH
 NDhtkP6VHXyPIytfFpo+j1hKkrTXFSIrBp06GRJVlZjjJrZOaSrI5CWteXaEg4b1nO2j2NkB+pQ
 M7pcj0RODy2u/LV+0XEZ+FdXAqtvbVM9FpyWlyJ/Ix+5uEG9tYKYO1ZXuMqRJ8yiumN851Agx9a
 glKL+U9UITf4nPo0N81nnBf9y5y224zhX/csXN/HUguwAF6TySyMaBT5KZHXyruAE+S9LKbaDjE
 1SEem38JbzcJ+THmL+01RkUFVX0Y006Uw4kK+J6kzbz6eBNPWGL/MEaQsd8OgFUlMT4JVwPUqLk
 OTfCldUYMhjDmQ+QYo2eqNEuXwZYr27iAuxYSR0RYDpBfaI4fSGX4pd+kSItVAPj8ZKyc9qQVJz
 b3/9tX3PXWNphVly91A==
X-Proofpoint-GUID: aPe3lg0cwJYE8Duslnrm1zRhApu-6Yce
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060170

On Thu, Aug 6, 2026 at 5:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > kernel.ftrace_enabled=3D0 is now refused on kernels that deprecate the
> > knob, so the old disable/reload flow no longer applies there. Probe
> > for this with ftrace_disable_supported() and keep the full original
> > scenario (disable, fail to load a livepatch, re-enable, load, confirm
> > disable is refused while loaded) on kernels where it still works;
> > otherwise just confirm the write is refused.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../testing/selftests/livepatch/https://urldefense.com/v3/__http://fun=
ctions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSU=
hPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$   | 14 ++++++
> >  .../selftests/livepatch/https://urldefense.com/v3/__http://test-ftrace=
.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSUhPg1KC=
QGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj6oTNhr1$         | 45 ++++++++++++-------
> >  2 files changed, 42 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/livepatch/https://urldefense.com/v=
3/__http://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTt=
sCXR9obFozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$  b/tools/testing=
/selftests/livepatch/https://urldefense.com/v3/__http://functions.sh__;!!Bm=
dzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSUhPg1KCQGTvfgZ9oT=
wgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > index 30dc677b2f45..a65b7b1ac8ad 100644
> > --- a/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9ob=
FozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > +++ b/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9ob=
FozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > @@ -126,6 +126,20 @@ function set_ftrace_enabled() {
> >         echo "livepatch: kernel.ftrace_enabled =3D $result" > /dev/kmsg
> >  }
> >
> > +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=3D0
> > +#      can still disable ftrace on this kernel. Newer kernels deprecat=
e
> > +#      the knob and always refuse the write with -EOPNOTSUPP.
> > +function ftrace_disable_supported() {
> > +       local orig result
> > +
> > +       orig=3D$(sysctl --values kernel.ftrace_enabled)
> > +       sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
> > +       result=3D$(sysctl --values kernel.ftrace_enabled)
> > +       sysctl -q "kernel.ftrace_enabled=3D$orig" &> /dev/null
> > +
> > +       [[ "$result" =3D=3D "0" ]]
> > +}
>
> Since the selftests are shipped with the kernel code, I think
> we don't need to handle backward compatibility here. Instead,
> we can just assume disabling ftrace is no longer supported.
>
> Thanks,
> Song

I tend to agree but I think here[1] Steve and Miroslav asked for
backward compatability. V1 was actually the way you prefer.

Andrey

[1] - https://lore.kernel.org/bpf/alpine.LSU.2.21.2607311104390.25165@pobox=
.suse.cz/
>
> [...]
