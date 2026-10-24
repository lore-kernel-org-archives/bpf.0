Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792806947;
	b=S0Tf48KnRNcI3dn4nkX/3YYMBY2e+vHGQbpDYu8R7SrKQg+peTvtXWIvtFBcZjv5rdHZ
	 vmC1eCzy/uJGHUd0JTYj/i2+4V+s6P7pwJ4e6TsvKXlnVgim9+19vouFwfBcAOoeVK/k0
	 hNyA1JFOzi4oH4vRGNIt/9TpHDD99no6hTTZwjjVJ4vOagPz7nvlOmWyZrgRsTrNyAPnA
	 NgJPVlnfZC3cExgfvn3z8Puxpcf9KnUrzNx2DlD4r3HoyXWgHACDCPiU105Y4GRrLLVdb
	 2NpLQGnY3Ly+HUMukes2w/a2DN4koDLfST4qTQV40vrIWCkt9RzwEERTwQuWM5PdrEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3zuRZPnf8NmOtPITygHO4O6eFGhGEbk3NE+q2TVvrlk=;
	b=wQju0pVmDqHWPfXzHF8kvCMVCrk2cBFJ/eJe5BgTJZiXKFxjlYC26qrvO4tPZNarCPH8
	 127mqPhH1FemEtCm4sfWronRFn9fnsMbTYJLRf/+DrfZmT5gvQph6/lAGZ5xw1rPwuaYx
	 8jPhq9Yq6Krrl66gP9R4+x955olNCrpu/80C9HaeREX4ttFFB/gbcemeOwuuIdEdrdULM
	 3tvk5wRGE+ia46Bg68He1YsSXhZh9btuFV4e5KhLUCWXOCE2KZrSIbphMhST4GVZN7UQN
	 KteIF/P4XO/dEoKrOEjJoUu5HJ2LyNdMdMfaWhoVA1UeRXJYgFciPv21kxwlnTxQUDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=CtdTHN8o;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b="F4H/dtQ4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C509606A321
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C509606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=CtdTHN8o;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=F4H/dtQ4
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O0c1Bk502336
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=3zuRZPnf8NmOtPITygHO4O6eFGhGEbk3NE+q2TVvrlk=; b=CtdT
	HN8osfqbh+ta/7xXp6mSBq2pnBalGGY4BCyb0/P2FP9Lvj7KKalLGaGkVcc9IWJf
	haS98GZNggeGqgr2wIalH4J+AA/5OOiWwAHh9UL57wGhYboeUcWH++yvKV9uBcWI
	pqnNYg7AqDoCA2CKEEal3PS8YC80WE3dcGllQpg8wWksTXTyUkqmTkNRuU6+6oVO
	8h2fFzmwk3o/UQIrlEKmlhDRkW5o9UNZTxQ6xF2htu27QbtYn76KMnsh7Yq4Q0r+
	by4hfGCkzWQ3q3ryI5kv8wIU+308AtuNURkN8GKaX47n6g+yBK16Zyhb6Y3z3lUm
	l8s8TnkZACDfx6jUAQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hgja6r4e7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:55:45 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-679a3664e1fso2407774d50.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 18:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792806944; cv=none;
        d=google.com; s=arc-20260327;
        b=Z6ohXHa4uWUN7orShXFRtHqY7tRtvppqgw3eJ3d8BO9GLxCmN69WNhP7h9feswGn2A
         V8lu5OWtE21Vi5Xv6b0sTabLu/eUdwoN8unnLtLjKsiE+cBxE/UP/VHqxwnj0601Sv4C
         1hGPfV+7ZeEMWP1J64CJLJJxrWdhBkngGBziVJwD7WYFsfLtuN4mYbpO08b/JnPmQrV0
         JvHVn8nHk4k6zj9ndyf56RBkTWlYFB99pBk1uwI0+CYbEwGu/CCx1PYSjhhNRYzEFhOd
         9r0dnJih9Yf5Zrw98q32UqSuFejMjekpGMqkKOKQwrbuGoRvs+GbPNtG7tUX0r30et2N
         rsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zuRZPnf8NmOtPITygHO4O6eFGhGEbk3NE+q2TVvrlk=;
        fh=zxca8D0yP/A58Gmh/uG4ojyhu1MM8SPLKRaDXn52Dzg=;
        b=ej2VT4m5anwixlMKaETi/7V0fN8zVqgf9VkD8iL/9rF3QwLpUxcmJrmjmyyvnSBHvY
         exnvbgsQE64elVzs4b+we+n2KK0p1aryD8HXG8xw/Wrg2jKqOZ56skZfptUed0DAELl1
         RlAsx/6/DEUk9YqOMfdnUGa7t78DulG2bVNwZzCm8PY9HB/7FUDiz3sLmSpIZ7HsBWCC
         Yp4PU06mbuan60AYeq9Nw0HqFVbT3igAv02Z2//PL5PZorADNDBiBxQ3Y2vKiuGO+vLb
         4hXKFyHBE44hST5sr0ybqjMYXBzTEcL7S680IQOh50d2nM9sfI/lNqAUfnfsyuYPWz4S
         uHOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1792806944; x=1793411744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zuRZPnf8NmOtPITygHO4O6eFGhGEbk3NE+q2TVvrlk=;
        b=F4H/dtQ40i45sntp4LcyRawoo71Eepp11Nk3kuL8hsKrjEh8Xkm7Lg051PczHs9uOl
         GRDJICJxiUKzSW7oT9WZky8CEc41xLji/rKTM5QES2fsPcdtczq/dJoUz0HuwPdCAF6w
         OvTXwYgveYM7qEWi384FKPhP5TXcbTS7rUZKmcwVsZ/d34MNK8h4Y0AMT1ZBgnLVWk/R
         XNkdzdJ+jq/vGof/TbimNi2rbsTeN11FDenk14nfoGg0qpnwG0Z7T3zHd9PvDUUU5kl9
         hyE9gG0gfReg2rbhqeXnmeigG2ySqWUn6s//rCfVLADWwXLhdL1H7JQCu6TFVTY6UdXq
         FgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806944; x=1793411744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zuRZPnf8NmOtPITygHO4O6eFGhGEbk3NE+q2TVvrlk=;
        b=i6rUmDiP8uuRYrYQcYuSgoglP7BcprFTEpX6CiD8O3Wp530pwjuTqsibBH2cmWjPcU
         hgq6r06JlBt7yyi3PDh3/cbL0UUDkXO/CLeudtpq2C+jy6np7SG+ptJfO/6F2FJEaVql
         9g7oG7OJc4ArWFKtyJZsph2EUSPY9lXgcTaH9wqbOjgOpB/rK+HQJmMpeGYPz4YJQe8M
         dmj2KUCuNhK0LPkP0kA+R/8Wc+ZGM4Vu2czpI9h3pXsU+wE0BViIFYMoNiwgJ6XzQlD3
         TPBzjyuXRY6K72nb24JvI0pFwakrxrVnu8+MvJOi0eLvnMuTYGRQn6ry4apRVzyjiS/R
         i+Tg==
X-Gm-Message-State: AFq9FYIClZlUY1V7UUG5irhvvmArzd1pbI3VgN5EEsI84oHMwJTal95l
	ihUxtAd2J2ZMc6aXipW1lPVTzb1937HI+280aldLbiwJ6N9OATcAtGOUYU//+FCw2ESh4R3rQi4
	v2HG0JA0rnMOOd0zp659IbB9b5WX1e5djaL7ZHOum/v1WyYC6/BMO5FD4d6C+/GLU20+WlicHy5
	xkrSPG6dzz7hNYxxvZZJGtmTJSBVMs
X-Gm-Gg: AYBFou2glYRfghzNKB8zjSoXvx3rSLuRvWE9jn12BXfFNsy2YUNLXn8p5hRwzvc5uXE
	wTN/jHtHnoidJ/0vOKAx1wmC4lGTOeM0vOozvXJBG8/TQeOmedTK2Y8V7C/TYaW9+ZpNF8PG7Aw
	N7P0XEcjijqwQdl7MZyVidY7cZeljN1/DFbk6RnpAhVPjkz60389ze2F41mg==
X-Received: by 2002:a53:b194:0:b0:671:26c4:3ac6 with SMTP id 956f58d0204a3-67a453cb821mr557345d50.37.1792806944524;
        Fri, 23 Oct 2026 18:55:44 -0700 (PDT)
X-Received: by 2002:a53:b194:0:b0:671:26c4:3ac6 with SMTP id
 956f58d0204a3-67a453cb821mr557328d50.37.1792806943955; Fri, 23 Oct 2026
 18:55:43 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
 <20261010143156.379864-4-andrey.grodzovsky@crowdstrike.com> <CAEf4BzbF3d08Osi5pQJDFcEKaJiaRW4tH4LM1vzBOOmOrXFpGQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbF3d08Osi5pQJDFcEKaJiaRW4tH4LM1vzBOOmOrXFpGQ@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 23 Oct 2026 21:55:32 -0400
X-Gm-Features: AclHuK-Awucw5gZMwetFY2wXq38H-UiqcVOX2c0crI1TBsHREUtvaDT4o_AsmTs
Message-ID: <CAOu3gNhd8hLWkXeX04VY0K1UxJ7Wb5WjmX0i8qZEmTQ61LQP6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/7] libbpf: BPF programs manual loading and attaching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=UKlIjyfy c=1 sm=1 tr=0 ts=6adc1021 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=Pgacwa0oAAAA:8 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=opz5rEvCd2MSMhsKk2wA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=xnLNWz09G3ZUmE6K9NTY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNyBTYWx0ZWRfX/s4AzUA91XoQ
 BPtQz+IFSuprPQ+5UtNUvtL6il97ZRQWws3kppyP6RnsxuO5JSkoxRZeoXHsfmF+88xKOUaCBSg
 NlFD1A3GgI9HARlpWR9erXnx2m2FAF2LtXRiBKehJjSjMV5si3da
X-Proofpoint-ORIG-GUID: 5uRPhfCHJ2oon6ASgxevQEtDYU9I13g4
X-Proofpoint-GUID: 5uRPhfCHJ2oon6ASgxevQEtDYU9I13g4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNyBTYWx0ZWRfX07zGEkTBlpC8
 kj64ArTjXkmLGLmI+v09mwhIXheS9A6Q0Id0KFSqo2pPzHUeksjbv78TJ2PXnUdr6tR1Hx0bT9i
 Ny4usEy1mWYq9QCux31DmOBPTDIExCgGbRc5ebuMZDnMysx98fJbg7cCOnPUQwaKUTtCNrMCtHu
 VtrbXnQ8YWf4evq9JuZQzg1xq+sj6D6TYRc68sQSQvkz9rN/zjkNyLWmdi0Vu3QeHtqw60i+4hv
 5dHU/xLqQRBqVbBQPar0LiPa8lorQJiOEMsBHhhatpzcgkv8MM2+CVJsAhKSEZJ176FgvA1v2G2
 1ydWzCm6b3FhHyvMCGC6bXJnY/d9UHs8Jk3QxtxJZpO54Kyn5+NBF1hu7aCZU7TfxD8SrjVb8q0
 Y5Io9K7dDccH+4KqexE0WJEIMJrUokaKBoa5ASM2YFjnJ0mQSeU8XBpUp6wm83FlVVv7DqMMLpo
 elVPTHfEiaJs50IyzkA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11944
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240007

On Fri, Oct 16, 2026 at 3:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Oct 10, 2026 at 7:32=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > From: Slava Imameev <slava.imameev@crowdstrike.com>
> >
> > BPF programs designated as manually loaded can be loaded and
> > attached independently after the initial bpf_object loading and
> > attaching.
> >
> > These programs can also be reloaded and reattached multiple times,
> > enabling more flexible management of a resident BPF program set.
> >
> > A key motivation for this feature is to reduce load times for
> > utilities that include hundreds of BPF programs. When the selection
> > of a resident BPF program set cannot be determined at the time of
> > bpf_object loading and attaching, all BPF programs would otherwise
> > need to be marked as autoload, leading to unnecessary overhead.
> > This patch addresses that inefficiency.
> >
> > A manual-strategy program is loaded via bpf_program__load()
> > and unloaded via bpf_program__unload(). It only requires that
> > bpf object is already in PREPARE state (BTF loaded, maps created,
> > relocations applied) rather than requiring a full bpf_object__load().
> > Manual programs are skipped by the object's own autoload pass.
> >
> > A few key changes described below:
> >
> > gen_loader is rejected if any manual program is present since
> > this loader is finalized during bpf_object__load()
> > and so it will miss any manual programs loaded later.
> >
> > To support veristat conversion from clone to manual loading
> > a few commits later, several changes to libbpf had to be applied:
> >
> > 2 program log related APIs were relaxed to work post OBJ_LOADED
> > state to fix regression where verifier logs were lost in case of
> > bpf_object__prepare failure. It makes sense to relax those for MANUAL
> > programs as they can load post OBJ_LOADED state so the log buff still
> > can be set at this point.
> >
> > Failures with BPF_PROG_TYPE_STRUCT_OPS were encountered and so in sever=
al
> > places code related to struct_ops logic was altered to take into accoun=
t
> > struct_ops program with MANUAL strategy set. The general idea is to rej=
ect
> > this type of programs for manual loading since those programs cannot
> > load/unload independently of each other per a given struct ops.
> > SEC("!...") style declaration is rejected for them. On the other hand,
> > bpf_program__set_load_strategy() accepts them because otherwise
> > veristat is rejecting them.
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 218 +++++++++++++++++++++++++++++++++++----
> >  tools/lib/bpf/libbpf.h   |  38 ++++++-
> >  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3=
_lV9HdKG8!06H-ciaovlRMIRnVoq3s3M1SHjFpts8xXiR6Tp_S74BpRCUtK3EVqsj55TyzxE8MS=
JRifdvVgsQgKmA3aa1i-F__23YwyxqUffCxfw$  |   1 +
> >  3 files changed, 233 insertions(+), 24 deletions(-)
> >
>
> [...]
>
> >  static void bpf_program__exit(struct bpf_program *prog)
> >  {
> >         if (!prog)
> >                 return;
> >
> > -       bpf_program__unload(prog);
> > +       bpf_program_unload_full(prog);
> >         zfree(&prog->name);
> >         zfree(&prog->sec_name);
> >         zfree(&prog->insns);
> > @@ -1222,6 +1241,15 @@ static int bpf_object_adjust_struct_ops_autoload=
(struct bpf_object *obj)
> >                 if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> >                         continue;
> >
> > +               /*
> > +                * We avoid this for MANUAL programs to allow veristat
> > +                * conversion from clone() to MANUAL loading. Setting A=
UTO
> > +                * for a program would cause it to be rejected during m=
anual
> > +                * loading.
> > +                */
>
> it's weird to refer to veristat from inside the libbpf, just say that
> if user set load strategy to MANUAL, we don't mess with struct ops
> autoload guessing anymore (or something along those lines), assuming I
> understand the intent correctly

You understand correctly; fixed in the later series sent.

>
> > +               if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_M=
ANUAL)
> > +                       continue;
> > +
> >                 for (j =3D 0; j < obj->nr_maps; ++j) {
> >                         const struct btf_type *type;
> >
>
> [...]
>
> > @@ -16220,10 +16338,41 @@ void bpf_object__destroy_skeleton(struct bpf_=
object_skeleton *s)
> >
> >  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_=
prog_load_strategy strategy)
> >  {
> > -       if (prog->obj->state >=3D OBJ_LOADED)
> > +       struct bpf_object *obj =3D prog->obj;
> > +
> > +       /*
> > +        * obj->has_manual_prog is set once in bpf_object_prepare_progs=
()
> > +        * and never recomputed; once the object is prepared, no transi=
tion
> > +        * into or out of MANUAL may change which programs are MANUAL,
> > +        * regardless of direction. AUTO<->DISABLED transitions never t=
ouch
> > +        * MANUAL and keep the looser, pre-existing OBJ_LOADED gate.
> > +        */
> > +       if (strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL ||
> > +           prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> > +               if (obj->state >=3D OBJ_PREPARED)
> > +                       return libbpf_err(-EINVAL);
> > +       } else if (obj->state >=3D OBJ_LOADED) {
> >                 return libbpf_err(-EINVAL);
> > +       }
>
> see my comment on previous patch, we should accept any change before
> preparation step, and reject any change after, so there is nothing
> special about MANUAL here, is there?

Makes sense.

>
> > +
> > +       if (strategy =3D=3D prog->load_strategy)
> > +               return 0;
>
> why this special check?

It was a left over from the saved_autoattach save/restore in v4/v5
that we now removed. Dropped in  later series that was sent.

Andrey

>
> > +
> > +       switch (strategy) {
> > +       case BPF_PROG_LOAD_STRATEGY_DISABLED:
> > +       case BPF_PROG_LOAD_STRATEGY_AUTO:
> > +               prog->load_strategy =3D strategy;
> > +               break;
> > +       case BPF_PROG_LOAD_STRATEGY_MANUAL:
> > +               if (prog_is_subprog(obj, prog))
> > +                       return libbpf_err(-EINVAL);
> > +
> > +               prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> > +               break;
> > +       default:
> > +               return libbpf_err(-EINVAL);
> > +       }
>
> [...]
>
> >  /**
> >   * @brief **bpf_program__set_load_strategy()** sets the load strategy =
of a
> >   * BPF program, controlling whether and when it gets loaded into the k=
ernel.
> >   *
> > - * Can only be called before the enclosing bpf_object is loaded.
> > + * Can only be called before the enclosing bpf_object is loaded for
> > + * non MANUAL-> non MANUAL transitions. For manual it only
> > + * before bpf_object is prepared.
> >   *
> >   * @param prog BPF program to update
> >   * @param strategy new load strategy for the program
> > - * @return 0 on success; negative error code if the object was already=
 loaded
> > + * @return 0 on success; negative error code error.
> >   */
> >  LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog=
,
> >                                               enum bpf_prog_load_strate=
gy strategy);
> > @@ -2150,6 +2170,16 @@ LIBBPF_API int bpf_program__set_load_strategy(st=
ruct bpf_program *prog,
> >   */
> >  LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(cons=
t struct bpf_program *prog);
> >
> > +/**
> > + * @brief **bpf_program__load()** loads a MANUAL BPF program. The encl=
osing
> > + * bpf_object must already beprepared.
>
> typo
>
> > + *
> > + * @param prog BPF program to load; non MANUAL programs, already loade=
d
> > + * programs and subprograms are rejected.
> > + * @return 0 on success; negative error code otherwise
> > + */
> > +LIBBPF_API int bpf_program__load(struct bpf_program *prog);
> > +
> >  #ifdef __cplusplus
> >  } /* extern "C" */
> >  #endif
> > diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.ma=
p__;!!BmdzS3_lV9HdKG8!06H-ciaovlRMIRnVoq3s3M1SHjFpts8xXiR6Tp_S74BpRCUtK3EVq=
sj55TyzxE8MSJRifdvVgsQgKmA3aa1i-F__23YwyxqUffCxfw$  b/tools/lib/bpf/https:/=
/urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!06H-ciaovlRMIRnV=
oq3s3M1SHjFpts8xXiR6Tp_S74BpRCUtK3EVqsj55TyzxE8MSJRifdvVgsQgKmA3aa1i-F__23Y=
wyxqUffCxfw$
> > index 689de28fe436..9835e660350b 100644
> > --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!B=
mdzS3_lV9HdKG8!06H-ciaovlRMIRnVoq3s3M1SHjFpts8xXiR6Tp_S74BpRCUtK3EVqsj55Tyz=
xE8MSJRifdvVgsQgKmA3aa1i-F__23YwyxqUffCxfw$
> > +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!B=
mdzS3_lV9HdKG8!06H-ciaovlRMIRnVoq3s3M1SHjFpts8xXiR6Tp_S74BpRCUtK3EVqsj55Tyz=
xE8MSJRifdvVgsQgKmA3aa1i-F__23YwyxqUffCxfw$
> > @@ -464,6 +464,7 @@ LIBBPF_1.8.0 {
> >                 bpf_program__attach_tracing_multi;
> >                 bpf_program__clear_flags;
> >                 bpf_program__clone;
> > +               bpf_program__load;
>
> as before, please move to 1.9 section now
>
>
> >                 bpf_program__load_strategy;
> >                 bpf_program__set_load_strategy;
> >                 btf__add_loc_param;
> > --
> > 2.34.1
> >
