Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793313716;
	b=Gsc+/pUjvlwq+mWXvchFskbyrW7/+mBK/fW5/p025Qiq9e0h+Uz336lBYTh2ObFrRhNF
	 f0fbD7WdAAEjjd5cqVOgV82z33U8WjO6hL7n9HXq7kPSdZGWUxcHPZQsvzwPdBntx41ko
	 ViWgeLIvRpxJkmyZ3vuxnidWWtEmopHPVAA5EPYGVtYe0xcNDI5OxY//NJ8PQXMylbJwk
	 YFjX8j4J9QqxLFycCJ8ccG2pBeK/h+xSirWx3TbyMAUXgdUN/eVWviiG2x32UjHe4ytkh
	 XomMCDCQ1ZKOE1Hhb/Oku9+Loaqp6L+si06TD1BTQo2dZPR6j93l/MkXw2Z+YVeqrUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313716;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nEYgDsYRu7XPCr2gCkkPI1pmU7diMsdQ4sgw2JUnNxU=;
	b=Pt5+m00yZ6/nwzkCSf8TQFAf53bi8gKXgn7L2O4A2YPNwumrd4+xqWBNonxp+aX0aJJo
	 /MbUgyxZ7pHgM2kYqa2FRIFYs2Sey6wCAj6w9KyMakI5VYZUcZgQdTj5JtSgm8ohsvID0
	 A/zrkGEKIjiDAy38gQJJZX/Z8+6sBtgjALTsXy3SOZXwjEJFHQL/ZzeoFB1JjPaUvpOOY
	 aV6ydvL5me4bwxz5+zMasagTlSr7mMZ49Lmkl5RpozhQnAl9JiIPvYbvm5IXZ0o30mdAM
	 ZK2imNNrMVTmIH9xOlpqkLSjPQVoVPeZnav/FUYoiaWoDu7BOlKni40sJ1kYnONap1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=m74vDAfN;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=XbiRWfcX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C999606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C999606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=m74vDAfN;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=XbiRWfcX
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXEof2715502
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=nEYgDsYRu7XPCr2gCkkPI1pmU7diMsdQ4sgw2JUnNxU=; b=m74v
	DAfNQchqsVxVkQtPNAtw48insJTxOdqIRY56Cp37gzSUT+m/HOxiWl47NUMt4lSx
	TViIoWiJogIaAfnLhHZgTkW4MHlMxI0ksLqe8dZOge2IqSdI2NfPqyree3i+vOHm
	qNSzlzseFK7ldob7SZO/VZAZVuUlDTlxTBRog15mdNiDRGXnzsgT87E7M6VQ2RdY
	fQkd1n74xK1e2UMJsIOML5W9qpiaQfxOoP5D6ZBzM8JjcwRO3iOzFP2kaKtRu2UH
	6Y5etljMo7HrYZTnscKMKVOy3S+1yIKuDU5C8GPbGBzk1Msbbe+Y/41UgR3JZ0bM
	TNJRC/rydeTEpHzong==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hme5n86cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:41:54 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67906c453b8so272826d50.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793313714; cv=none;
        d=google.com; s=arc-20260327;
        b=eTgZOzmKD94B/FivZs36kZV5/5CWZ06yuvkZV3+Sq+tIoTiFtN4ClI5ebQGI8MT/X+
         puYa+hoVpnJA2ynKq+JMKRGAZCzQuUpsVUxPPl34k1ZxDp6ODqtOowPjfbsPE01nQjY2
         wvNropHemxYlhMfLBTeA4zxj1SUxOwtzGCi3Z5/2Q2A/AkFRC1/48eoBKizow9BuVSPw
         Xa+Y2JR6HA9zcdC/Wj5gr1zqMPv16YhVh2MReWsU0srKmyf6JNmFU81/Fszcs1kvvVVq
         aa6L+NZhU/xGn//iUE2ljqWncw7e7XCZKXeVEIzTXIzAKgPA4WlSPctb5fyaRGF/77zx
         h0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nEYgDsYRu7XPCr2gCkkPI1pmU7diMsdQ4sgw2JUnNxU=;
        fh=Sk/h9kDmk/AgoEHMlZzVb4nBIri4c+4Ya72fOlB0xDs=;
        b=LJ2hDRDz4UZFRDOdwsJ+Yb1gLX8fhzTnpGSFoycYyZ0xP7qXbhn0tPcC1+TPEyQ2Ed
         jaxJqAUezSJur5SDx0gz1SSR8hnyYkbxROez/1uMKMD06iJ8tGBcHzFbvXdZhiKx/Bdh
         PCE51SuYCOKgBPC8xxJBGZHh6CXvdgy9FdXLI6cubkqnWmtHl13AotqaSYPKmjovk3Fw
         DUcmSFNxjQvB8Q5ljmueb51aOmV+lvf7SpVqKnAjYqlwf7C+KFFKLDQygBLXynjyjSoD
         obUdtG+CIRB/hWJ2LxKOQdHVlhfrtDX2MVR/DTCm4JocwwFUStJMhvUYpMHpaSbdmcX4
         cBgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793313714; x=1793918514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nEYgDsYRu7XPCr2gCkkPI1pmU7diMsdQ4sgw2JUnNxU=;
        b=XbiRWfcXqvtQb5spiLE9Kl8OcMcP6+eMFZ9kLXX5bBsCUgI4x468G78IDA+pTkQP//
         PJOOANgT3mx04FJxyo5beaPJ6DV/2XAn/fkIDTSVkV00rV6ACy0CDdy3uZW5yhR368O4
         Xsd2MGGATWH/ke/oZzeUfBraGRTALT7bWeNcazxly/uXgg/N/BCSSyxbPbxF7NcJWc9w
         TFrm38eYm/hNvbS/zY3RLAy/unIM0hbjnhHS8jUoIBYeRD3/C/2mX8JfrtRvGsRL3tUL
         q2FFire1XnRJgzOUpu/gK+hlDToZG1e0VV3hsdN4xXc19rQLSkwwH893GQXsx/4oToOm
         zLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313714; x=1793918514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEYgDsYRu7XPCr2gCkkPI1pmU7diMsdQ4sgw2JUnNxU=;
        b=Y45cEPTkGsi8UhyVxmh4+jMfq8thlsC+OuqBvFnYWK3911+yGsJKkPAqxhDWwlvYaD
         5UcIp7hCIP74sYR1haHAPp2lrvJeNf+L7fDVKYiOKQkLHSb+1RtBiHOdmZAaBZZJ+L2I
         MGad6wOSyzbi6DoJol7R4w+xVvUNpukqBLhT/HSAWEvc/Bb43vg8mp3z8pdEkk5Dvknh
         FWn0sb5KLrSnRcwvAr2y+4g0RuY3GnBKTmgL9OHUMt+NhviktNE8t5qRSC+0su9enrKD
         Ly1RtXF/PCV42oSDqw8g7tMPaYwm4D9Q3+jgOTRYCpjfL0m1uCpPt2YQ48IiP/ggkiKt
         UgzA==
X-Forwarded-Encrypted: i=1; AKwUvBx/xYJ1iYMFAcaR17o9ZdxW5u29dbMIOc4sHI8WTlmVoAaYipMppVnN3Nd+sNXEXD4xUJg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNNVmPXKG+OHxStEaEkKxetvAL5O5FcQQ9Y/NTtkI1tUAAMmXi
	eMBU9pINSxvRvm5+a9x5ObfShPS0dgAnnhikubqWNC/DA0rz0BKlaLPPJOhdOLZtljGjUeUvrBA
	X1mngEz/YA06BiEOifkQIEElWvRa7rljQpBEj1ZCfQf8eCU0hBYdPwyAEKKOiOXeu59B+zwYJ6r
	PbN9OwcWllqU3ZGwzFYokp9Ni4cBn3
X-Gm-Gg: AYBFou3pHFSYaQ0BSmq0Ytq5fuluaJMhlAI25bf2T50SNeSBpsg5fM7gy5h3k2ITFCw
	d8lcbYp9KDNZwCOUjiZcl0kawmmyGytiKMiv9Ce4LwTIR9S0vLYxIfU5e3neiBF9CTxJl4upRc9
	RQFuimOW7zogjamceJ452BdpfV4WtdEYZosvG+R2Jpqt3Gz0AenVyvcTSi5Q==
X-Received: by 2002:a05:690e:13cf:b0:67a:860e:9938 with SMTP id 956f58d0204a3-67a8d4b3870mr2881023d50.37.1793313714272;
        Thu, 29 Oct 2026 15:41:54 -0700 (PDT)
X-Received: by 2002:a05:690e:13cf:b0:67a:860e:9938 with SMTP id
 956f58d0204a3-67a8d4b3870mr2881003d50.37.1793313713794; Thu, 29 Oct 2026
 15:41:53 -0700 (PDT)
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
 <20261024014514.2959514-4-andrey.grodzovsky@crowdstrike.com>
 <DMCRBHQKJP8Y.1KLS4ZA48PV06@gmail.com> <CAOu3gNgnhXnN_tDPnXVmnHAD5MNXwZ5iOc4kO15vy5cu1TpEgQ@mail.gmail.com>
 <CAEf4BzY0PSQc8ugHFk-BSZT=0GSYnL7B4bMLbVV6vHujLwVLTA@mail.gmail.com>
In-Reply-To: <CAEf4BzY0PSQc8ugHFk-BSZT=0GSYnL7B4bMLbVV6vHujLwVLTA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 29 Oct 2026 18:41:42 -0400
X-Gm-Features: AclHuK_xTEToa4lxoRuiyIbwoba-ikkBOsmIQy3zgeSEzIdkNeNmnurA6xF0LT4
Message-ID: <CAOu3gNjuxCEf07JpXVw0Rcuq6qbc1mcDOyMcTM0Zop1-0Emreg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/7] libbpf: BPF programs manual loading and attaching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: iZrbQXVS3QhsUt6vNIxXixuokQiCVCZt
X-Authority-Analysis: v=2.4 cv=F4zC5ahN c=1 sm=1 tr=0 ts=6ae3cbb2 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=bnuYKV3je7ezfTQf6e0A:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OSBTYWx0ZWRfX3DfKiXTpOxEV
 EGdNVNRPUlF40vq8x+YArBqno0loRZM1StWwg7nyKb9F4G7amoisXbR119FvJKK+sr5YvLsOjg3
 4y3FTDu0alLk+igxLWcr7ZWCUNehn6hynn9gGcEVNw2uDftn5ArhZq9gl71ykKnt/TEOajM9wf+
 zDzmnipjRkzdSj+fasomDjilfVyAvTY6caTNgHi8Ukv6/33TOm21LerIylRA8UvX1aW0aTum0Rx
 eqUeJ28XfQ8sneacJ8ABJo/trh+dXRS3DVzCmdYqj2l+Gk/52vl6i/rM1Tv5QC98sdrukygBIUc
 6GDksyuqe6ai2aefa6vG/ZiBkgz1NM5nlLHR6fkrwVEGsMaKQvEIUxvqCx02aRx6bHhC5eSIoZh
 V47dYBypu8aQizUis+dwHK8eAtYVX7tWg+rgianDUq5kUi2uV7dv+FgEwU8chH6BG7t8CqPokVn
 E/8kj0eKiHCwerQI2Ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OSBTYWx0ZWRfXwTH5JqaxbKTY
 /CG0fr0705pFiHe2gegwP12dYp1E8HjmmdnbUZHZHNwLkQLF2jffKY7UNexQ3PIQWchQtHD2Dtb
 epBI58Q3yO1JuBnj3TubBpZKdZhckHho5uxXandjtF/W33ZtHES5
X-Proofpoint-ORIG-GUID: iZrbQXVS3QhsUt6vNIxXixuokQiCVCZt
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290089

On Thu, Oct 29, 2026 at 1:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 27, 2026 at 7:06=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Fri, Oct 23, 2026 at 11:45=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Oct 23, 2026 at 06:45 PM Andrey Grodzovsky <andrey.grodzovsky=
@crowdstrike.com> wrote:
> > > > -void bpf_program__unload(struct bpf_program *prog)
> > > > +static void bpf_program_unload_full(struct bpf_program *prog)
> > >
> > > [...]
> > >
> > > > +     if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL)=
 {
> > > > +             zclose(prog->fd);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     bpf_program_unload_full(prog);
> > >
> > > No need for two kinds of unload.
> > > func_info, line_info and subprogs are filled by bpf_object__relocate(=
).
> > > Nothing depends on them being freed in bpf_program__unload().
> > > Let it close the fd of any prog and free the rest in
> > > bpf_program__exit(). Then bpf_program_unload_full(), the strategy che=
ck
> > > and the second paragraph of the new doc in libbpf.h go away.
> > > Do it as a prep patch.
> > > Something like this:
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 8fcb8cf..dd15842 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -876,10 +876,6 @@ void bpf_program__unload(struct bpf_program *pro=
g)
> > >                 return;
> > >
> > >         zclose(prog->fd);
> > > -
> > > -       zfree(&prog->func_info);
> > > -       zfree(&prog->line_info);
> > > -       zfree(&prog->subprogs);
> > >  }
> > >
> > >  static void bpf_program__exit(struct bpf_program *prog)
> > > @@ -888,6 +884,9 @@ static void bpf_program__exit(struct bpf_program =
*prog)
> > >                 return;
> > >
> > >         bpf_program__unload(prog);
> > > +       zfree(&prog->func_info);
> > > +       zfree(&prog->line_info);
> > > +       zfree(&prog->subprogs);
> > >         zfree(&prog->name);
> > >         zfree(&prog->sec_name);
> > >         zfree(&prog->insns);
> > >
> > >
> > > > -     bpf_object_post_load_cleanup(obj);
> > > > +     bpf_object_post_load_cleanup(obj, true);
> > >
> > > I really dislike bools.
> > > bpf_object__close() is the only caller that passes true.
> > > Clear obj->has_manual_progs there before the call.
> >
> > IMO obj->has_manual_progs naming becomes now somewhat misleading as we
> > still can have manul progs at that point we clear the flag. I am
> > thinking to rename the flag to skip_post_load_cleanup to reflect more
> > precisely what the flag's role.
> >
>
> instead of manipulating the flag just move fd_array freeing to after
> bpf_object_post_load_cleanup()? But bool with comment, e.g., `true /*
> force */` at the call site is fine for me for such a simple use case.
>

As far as I see, moving freeing of fd_array after
bpf_object_post_load_cleanup is not enough as we also need to free the
modules BTF fds and btf_vmlinux inside bpf_object_cleanup_btf so
either the flag manipulation or the bool flag is needed. In any case,
since it seems Alexei prefers flag manipulation while you suggest
keeping the bool, I just kept the bool for now and added a comment
about 'force' as you suggested. If we still decide down the road we
really don't want the bool, I will update again.

>
> btw, when do you plan to post a new version, it's been a while that we
> are iterating on this, I think we are close, so let's try to land the
> next revision

I just posted.

Andrey

>
> > Andrey
> >
> > >
> > > > +     err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->in=
sns_cnt,
> > > > +                                obj->license, obj->kern_version, &=
prog->fd);
> > >
> > > After bpf_object__load() this loses the fixup of the verifier log.
> > > bpf_object__load_progs() ends with bpf_object__free_relocs(), which
> > > frees reloc_desc of every prog, MANUAL ones too.
> > > When a MANUAL prog has a CO-RE relocation that didn't resolve on this
> > > kernel, fixup_verifier_log() -> find_relo_core() finds nothing
> > > and the user sees
> > >   invalid func unknown#195896080
> > > instead of
> > >   failed to resolve CO-RE relocation <byte_off> [..] struct
> > > The same prog loaded between bpf_object__prepare() and
> > > bpf_object__load() gets the proper message.
> > > Progs that depend on what the kernel supports is the use case
> > > from the cover letter.
> > > Keep reloc_desc of MANUAL progs. bpf_program__exit() frees it.
> > >
> > > pw-bot: cr
> >
