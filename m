Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793153197;
	b=niq5n+Amo2JJCFu0EqZvm0KH7tzx381/wxNc3PPuh/IgPr4a+RE7nFevC9T5nbujPbJ9
	 eKh7O/V2JPjBQqZFKrVE8xKVO7Vlu7eGnsMG5tbbT7mObbg798p+8MR33+l7hNCxo9MZl
	 79r3qU1mSENhGx6qX0cgUTVR6H+5E3M8+HVsYYBUQ294pc6xC1xrGYcNu2UmZ6I24k910
	 VRFdVEKku/EYIkydRn9iOsL4dmqSbZEt/bdpg4SUWsBV0RN3rMZi/cH/ZToFQRg9GpjZS
	 vDXrUDMCbFmOufHLKY48om1Yr023ykorL8B/5A4KWicWiKuxygO6iaKn8Ke9RjLeiug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153197;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=o9LpxKbP1+85HPuiwdkjl47nDRfJ92hAL1N75wdK4y4=;
	b=EDumtCD6oRXtdqw4QUweMWy40eD9EysKS9XEOiIcWlHsS8JL+6+csTOTG/8M8uEqOaAY
	 ddjl9BTxPn07mlbLq5t1EvmvWBTp/x7H+96syYd1igbGwrxllkskSz4ETo1ViZetbLq2x
	 NVAaj9cCDt6oYr3q4MJOzGfZT1Tb2q1MwhHgPyiUCoVVmYSsagyU7HKTghNsAkKDB8MP0
	 wJDpYxHV4bBl7cFerTUz2ZDp5Jpl/4ttHAt+0SmOBlaX3EbKTLhW8f3U/oxUZpfcB2NWK
	 /0lkJYdLcPOhKcxkLWtAOVkmTxixA6AIilbm1rJNKYG1InCqclRDS7RPbbVp8/OwhOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=YadFAgRC;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=klOgfOfF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E460606A325
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E460606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=YadFAgRC;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=klOgfOfF
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RKx94V2709790
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=o9LpxKbP1+85HPuiwdkjl47nDRfJ92hAL1N75wdK4y4=; b=YadF
	AgRCMOsf3pRCloyzEyXPaqlWIBsLPQQZu1xRcnT4VqHf8jOwxzWh17m/PL6kGjb2
	8LSozQxH3NUMbFLkeFe3yRR/GDEtvGlOrdCX/Qa8LRyy55wf3uhUTNSTZLlVK04e
	KMm5KvlDE6UVVv2OcX4/jT8VAlae4ShBznikfDdopsUzzKAp4n+7x59EHPjbc2Iy
	uVEdgQGHf5xtaJOYoz6AnRDerIA3AqU/eyKrMCHyTaLh0fIAM8HChtD4eeGaH8Ki
	RlyGatVPpoJws+sWo8iZhbX4yb+4spMG/nb4JkC6kttKXlteYP1QS/LMpBBq775i
	mG6a/6cbdVwQmlU7+w==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hk3fp90d7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:06:30 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67682d4d684so871449d50.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793153189; cv=none;
        d=google.com; s=arc-20260327;
        b=kVRVZqkiXXF5Etlv6W9bpYqnDLxZlBKBoO3N4Ga1a7H5Aq/EjES08K+6rXg30XUXgM
         NvPCtjDEAjCasIKQcTcH8gguqyLYDRvQ6JKKIlGOEryDGZHFxfnLoLlQu3BylwYTdIw5
         d2aqGBRv6sTCuBAJJpAg0+3qbMzKAjMj+pwnVd2rHwS7DlHDULJbGCSTqrm7LVd4DEhr
         e83b+nDrPDGpzsV/3x6lSqhBrSwN4ojWJYgBF1SH7OVaAXDjkh+XhX44cQ96mhXtocJ6
         uqGdQt1w+gUZJA4fbDj4LhAkezI/ElZdQUFeLa7tUb19Mg+Pl2MXriKfhQ9K5+nhQWY6
         ZXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o9LpxKbP1+85HPuiwdkjl47nDRfJ92hAL1N75wdK4y4=;
        fh=PRMeLRor6pSXOXRdbbtI03APR9Fzf78v515hv3GaKAc=;
        b=omH6uZyPEW1VmLhKtgsuZ/XD/LDSUmySSHSro80NITyo0hJAhsNtqw8t2U/cTSv+dd
         VCRp50k2isS7PmbXMcnt5BV0MKondZORnEwzE+/FahLZBY56v7fWx7adZwkIXoufjWZo
         03VC0nrMXWWBdzKGXM1ZG1HsT/OxGvLmnfE1KJXAFBkvg/+v3e9xzyczv17IjnDoF6H0
         lsKfX5HdkzGIxFG1dEBfDYp/TYbHsawdQdC75wTTNXUf15TNv5/Qwnj2CC5kayhqruLv
         PQnM+UyOMnvcJ0E7+HS5cByDXHYiQMaRWU8DMvWaL3v7m0L1cB48JMNysjib3Um/3KBw
         oO6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793153189; x=1793757989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o9LpxKbP1+85HPuiwdkjl47nDRfJ92hAL1N75wdK4y4=;
        b=klOgfOfFJl2exK7uGCXwpCQXRizEB0fvMuNyvkI2o0mApLuFMheG0Bv6qpFXeOluOZ
         SiVituKEwg2+VfDIowtePqsEqCGLloiCMnwvXBNjiBlK4DR+Lkb3ePBy/1M7IS0f8wKn
         gYXetwuBkJW2amEw9ZkxzU+fM/Lae44eLiOE32xmvGN8Np0NVwXRDXS4w1yR/JBRTC3q
         62+/vluglznwKASwi/RCgOAs71x1cjPLPhoFnOXt4fvjYrPBzskDhi8d3vt2LBSK5QK0
         PY/07Tv90Hpor0UnbXtw/2n9kiFJ+R91vYA/pdpt695qTwtJ2jQoCIui9lCw/CTRVxwi
         /yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153189; x=1793757989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9LpxKbP1+85HPuiwdkjl47nDRfJ92hAL1N75wdK4y4=;
        b=OJ6nKiQX1jL7xzSvHY+Y1NIgmcs337F2lPFKLxio+lMyGSwYUc7eQiUauFiCV38Gka
         L1tFHAAVJM71fTFBqXCBT54P2okNM2gISt7QW9pFMAclOrc66R2rkwpLmNshzXJTaXAb
         v4bpdETRBdeKYh8AmxsI2XcRwvRKJJRotNfYQeO7UNbqrVhefP952qC8D4ArLLpWXBBf
         J0FNia4SZLye7Ohmo427EhHs6OH0dEF6AL7XHcqOIcwjEMLMIlky1teFxH2L1duF7Tjf
         6nxoYj3c0AQWu4moN61qY2XvAZae3oObmKzVLVpRfB/cIhqSasYK6ExLu6Q60tY8srrw
         tcKA==
X-Gm-Message-State: AFq9FYLG8PCm2DHDEQ0F8KYGoQqO4FdJQxieC+7mFd2ZMSnr2IJKiI49
	zlWIEywydgSmrWDHseZNt+6fCIz6LGqBYtGDbEycj4zCIcqeNOgCUWQA+1r9EUcEIqgpGZQ4cwE
	sE+Mu0qLchPLeGobrhevMMBYncMXpiVB9hoPSX0o4rngJ72xFGwLM+xQBOc7WFRXeGs3OwVsHsk
	M7MO/wXktH3sAYyPrJzylMXq+B67PR
X-Gm-Gg: AYBFou2DuJMe7VZM+oNdyuVJPF805gK6S7Gz3kme5iKNL6GK1PJ6huG93JQWdvHwI69
	RG6SqXOsee7OXhXZVRH+7hs2Fmt6l4V4PjRG4F2pze0etOjyrZsj+f29KWQWoZYegZrGPqZRErQ
	0RiadFETHmTZBQBiLxbbtcmd/APkKCVEi3RKPYY7IRMkDF0a0XMINXIYf1qA==
X-Received: by 2002:a05:690e:1697:b0:67a:2ca2:8a39 with SMTP id 956f58d0204a3-67a7b992bd8mr932700d50.3.1793153189297;
        Tue, 27 Oct 2026 19:06:29 -0700 (PDT)
X-Received: by 2002:a05:690e:1697:b0:67a:2ca2:8a39 with SMTP id
 956f58d0204a3-67a7b992bd8mr932690d50.3.1793153188895; Tue, 27 Oct 2026
 19:06:28 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
 <20261024014514.2959514-4-andrey.grodzovsky@crowdstrike.com> <DMCRBHQKJP8Y.1KLS4ZA48PV06@gmail.com>
In-Reply-To: <DMCRBHQKJP8Y.1KLS4ZA48PV06@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 27 Oct 2026 22:06:17 -0400
X-Gm-Features: AclHuK_uaRBFc_Ihs9uTVHH8NDjYzK6e2pJg9z5Na5Qj3QPCUKlL8RR81bt5oLM
Message-ID: <CAOu3gNgnhXnN_tDPnXVmnHAD5MNXwZ5iOc4kO15vy5cu1TpEgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/7] libbpf: BPF programs manual loading and attaching
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwNyBTYWx0ZWRfX9kd2d9K7LZsT
 YiYVJnxZC7bwpxD79YIlA3EwBF5iqzORqcersfWhDM7XiZPxPbpm2gex0BGRpcPZM4FfT8liG2w
 Tvo2VeNKdSXasuTsuBvM+lo+e0IJfeRwabm+8Z/6omwUjPFcGXZI
X-Authority-Analysis: v=2.4 cv=d8VgWhjE c=1 sm=1 tr=0 ts=6ae158a6 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=c2uCcFg1m7qNNlWLQSYA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-ORIG-GUID: rYVS27NzUWwBqN0vhR378tPkOHqfLtMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwNyBTYWx0ZWRfX3zo/T1osRF2E
 Tc1Kf27TMRGdJC8G4G9hsRu8mIHlnjrCqR1SP3vkUvMpxEOsnLNGcJnSGH4+3JGt+Cu8iYB6sIW
 /l8Hj1vODFDekVMP470dTHaA+4tPv2mfWMO7ySCphhULoq1QfTg5CyNTJjEJpW0/tU4Z/fgbl3/
 rXDMXzAABSikGQIuS9hTDYP7y3iBBMRDdGiFvB9UTv/E/j+L/kmStwm/a+fn3M09w2smYaULlIg
 R6qfKGWJHdPS3ZBaP7AjKODoLVqvRR6AvSIwJW1EhWX0eVX8QH47gGFqcXf40fNRGcKMNNLq4vk
 oEg2t2/bJkgEVT/3QrBkI01rJyTWSlvQJRwGXH9syhpVtA2uYpqrqj+oZ+GPFtiZsCek1JQFhSt
 /69mxvR5cUNSjI7okVgNgPRLJMGyEKK4A1DZGZc9qjaX9bKgyYYhnnpPuXNfQGwRTAWuERfq0Nh
 K0d/VZPi9ERXrfCqdaw==
X-Proofpoint-GUID: rYVS27NzUWwBqN0vhR378tPkOHqfLtMH
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280007

On Fri, Oct 23, 2026 at 11:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 23, 2026 at 06:45 PM Andrey Grodzovsky <andrey.grodzovsky@cro=
wdstrike.com> wrote:
> > -void bpf_program__unload(struct bpf_program *prog)
> > +static void bpf_program_unload_full(struct bpf_program *prog)
>
> [...]
>
> > +     if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> > +             zclose(prog->fd);
> > +             return;
> > +     }
> > +
> > +     bpf_program_unload_full(prog);
>
> No need for two kinds of unload.
> func_info, line_info and subprogs are filled by bpf_object__relocate().
> Nothing depends on them being freed in bpf_program__unload().
> Let it close the fd of any prog and free the rest in
> bpf_program__exit(). Then bpf_program_unload_full(), the strategy check
> and the second paragraph of the new doc in libbpf.h go away.
> Do it as a prep patch.
> Something like this:
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8fcb8cf..dd15842 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -876,10 +876,6 @@ void bpf_program__unload(struct bpf_program *prog)
>                 return;
>
>         zclose(prog->fd);
> -
> -       zfree(&prog->func_info);
> -       zfree(&prog->line_info);
> -       zfree(&prog->subprogs);
>  }
>
>  static void bpf_program__exit(struct bpf_program *prog)
> @@ -888,6 +884,9 @@ static void bpf_program__exit(struct bpf_program *pro=
g)
>                 return;
>
>         bpf_program__unload(prog);
> +       zfree(&prog->func_info);
> +       zfree(&prog->line_info);
> +       zfree(&prog->subprogs);
>         zfree(&prog->name);
>         zfree(&prog->sec_name);
>         zfree(&prog->insns);
>
>
> > -     bpf_object_post_load_cleanup(obj);
> > +     bpf_object_post_load_cleanup(obj, true);
>
> I really dislike bools.
> bpf_object__close() is the only caller that passes true.
> Clear obj->has_manual_progs there before the call.

IMO obj->has_manual_progs naming becomes now somewhat misleading as we
still can have manul progs at that point we clear the flag. I am
thinking to rename the flag to skip_post_load_cleanup to reflect more
precisely what the flag's role.

Andrey

>
> > +     err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insns_=
cnt,
> > +                                obj->license, obj->kern_version, &prog=
->fd);
>
> After bpf_object__load() this loses the fixup of the verifier log.
> bpf_object__load_progs() ends with bpf_object__free_relocs(), which
> frees reloc_desc of every prog, MANUAL ones too.
> When a MANUAL prog has a CO-RE relocation that didn't resolve on this
> kernel, fixup_verifier_log() -> find_relo_core() finds nothing
> and the user sees
>   invalid func unknown#195896080
> instead of
>   failed to resolve CO-RE relocation <byte_off> [..] struct
> The same prog loaded between bpf_object__prepare() and
> bpf_object__load() gets the proper message.
> Progs that depend on what the kernel supports is the use case
> from the cover letter.
> Keep reloc_desc of MANUAL progs. bpf_program__exit() frees it.
>
> pw-bot: cr
