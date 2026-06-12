Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB571B652E
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244240; cv=pass; b=ZgJo1KzZhlACO5rf3rllbQpHkNEnM+v2YxAFXSfZXkJx6Po7yvIN/FcyinRuus2dARV/+uCmSsSvHzlOSqTRexGNKXAZSLuHZz4zJ1yRhmNhLzD0pWtg+SE1/5H16hegUnJ2iYQkiMnujJcnQhyQSoSbJ0CrAYqPNKmz9lyHQ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244240; c=relaxed/simple;
	bh=JChxOKHDMlUFH/AxUTSlme3Q4ZuCazL1Ek5LsdO+e+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyeGoiCqQm7GGNL6xQMZ3faPr+i/FTPJXLXIFEFbskOhWlS5UXfmMMFuZSjL23MiNEK2V2nW9OHyDz6TnxIU2PgLGwG+SSqTpP5ugJjCuIYODTROpUlPLqjRALrdhpBdOs2eI9rA1EVLPkODXARMDw4sOjKoKZWqe3dhzC/wbRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXk9OHTc; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXk9OHTc"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd523634so932617c88.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 23:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781244238; cv=none;
        d=google.com; s=arc-20240605;
        b=W4c7ABQYFp6zvLewJuWbvIGY5YUkg96cmZw4vo0Q5ds2ejblljCNbaaHsrLYC+kKty
         plUc0gfxTvd9avdfCXoE2xO4mmoUVbMyg2gDZpiDY+jWXfJImnqBm4A6h+FcwDdX+30o
         SUAje6/L7nRmi5qv8nNHzuZn4kK7SKzOUjrDRpQYAHVtwb0T7TBJCzNKwWl3ERNAhOTs
         lrMd/8G60P4aMQe86W5DP7bPz+c9yJyNO2z2xBelv7lOJWpG1oy8mpM0fGXYl8J5+bEI
         qv1DxDcKFS/LmUhsN9+qQuqgndXFRitrK7Qtxf47KsmXnRXKX3q/y56KmO7ZkO1dZKhN
         IUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wp35KpTh1/XiSIGSqXjoBqF9JP9w4suhLRUG1qQ2nnY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=AJO5EeCqFJ4qJHHuy47RiRywOKdZj/Cs86mWo7NUQXyN1j0K3MZvuTIzXHs/tH0YnJ
         y5SozB3ZbIpIe+9ueO+M+KuMGyiN6IzPXAkoYQmLbZkb7tUVNEE2usinC8/klvSFcPtB
         Ebu/Ox3Med9uyH8gmNzOF56acwTB6BDTGv3wf2oXpqQz43085bMEL7jrLNPrBpX8wOqm
         dqT84W+aE9ceqxCxu+m3hM3GqNMhXibrFh90JmPY7j73XXeM+BkWd/geMFktu1Hcfxi1
         Kod/HXc1YxxL28ZP5a41Zr5QHvaJQsPpTfMoiH6+fZVi0n0vCHEH/5FSCr5heYa9pRu/
         yD7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781244238; x=1781849038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp35KpTh1/XiSIGSqXjoBqF9JP9w4suhLRUG1qQ2nnY=;
        b=AXk9OHTc1ZihGe4S3GH3PCdtYqVPqCStl1aJNhhPTgfuPeduzR9q/e3UldlFchpDAP
         pJV8E+yZQtwLuf0wkVMPufBHl8e+gbynyt65n+9qZpaqkGk/YpuVOLCHhceN/r2qsy9E
         4Pf928UZtoU5Kh7nK7udNwc2lRQE8U5BJRY+XxNcEFmIA7RBqizdgNeEzIVDCD812/Rj
         ahfEVOKyXEbSnNA/2NF2m3gS3jq0Xru4JKAM4esZ+P0pVyuXWHqVAqg3eibVxhUmTZw6
         szGW7Z3NPreu+aKB3n4ccWMbC16SURPkLoP1z6/ph4tnmG+H7NOTYZ5nFd34xyugCTAy
         9rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781244238; x=1781849038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wp35KpTh1/XiSIGSqXjoBqF9JP9w4suhLRUG1qQ2nnY=;
        b=UaP4Owd8yfeUGEtnszhBaEPXaB7uCmDsj92P4sReKunhB+KwJOEngrksT7nBdhW5a+
         lPvnhc+R4z2aqUci42DFPS6Ir1qVwbZPZOuEKMDP8Z9wDAci3bM/hgTVUtgpIY6OQOAU
         XbOsxYoyNtIsrnee77DsI11c8RymhM4rFD5P+LkelVrjg8NNUCU8n022xlRTUqQi/e9S
         lNRGMhmKKN8xMVT8A/+vNS0ox8GdBd2MuVVy5YtfDgoK4Vb4ilf8VcEElOIgQWIatlvu
         6l/njTpGKHt7yAMoZ97M95kmaW3oRNif4fMKgZpq79HK8unGJeshC1A1BiDQS6L6EXJR
         epng==
X-Gm-Message-State: AOJu0Yy1nqmdYcHx9mccCGz1TRMcvHmwPlc56Lmiye08sApyNGoaBqJQ
	nbR1y/8MbPfqv6LFsVmVkwMvoLJsclTttq1MNlQMkdwpoTCnetXmNk70D+q2epPns3lRFaxxm/6
	5zyuyOOTxnPVmmfx2klKnQLQi/ZVxaAH7XSmajzdCgH6KAgc9Cb+q20DbDLroZA==
X-Gm-Gg: Acq92OF+mlRg8wru2zxXpYCIzB7KOi0LJX5OlrOFgx8wChYlZz5QNlcXkTi++a1lhHZ
	al9nEjk5zbWR+JK/ComU0YNUc000C4d51zvQw2Kisn81SubXMxM1MwY9rPuxyH3RYLrPRyuH1VS
	J+qDESAKlaMGZXOi29wY7r0fRwbToYSZf5sUYAhts/YRmfItStSCpUA29IACOD3I8WR4q0Ji9GJ
	eC8GB8rEx4hh7HMhmqe0X5+w4vGVoT67SaTcKX1rDeWTm/ri38EFMhCo7pHjTroemFZ39LOzwCe
	ZX688T5hf838IPEw/Ul7ssvz7ulYMF7nqdWKhpPyHaOvJaULbimLWIf1Szs7z10Qroaq2OoIvL8
	8uEt4hsSnXlsJt1bv0zpWEi3V11kgjz/y0EgqohyB9BxWySusYFZj
X-Received: by 2002:a05:7022:6b82:b0:138:49ea:f468 with SMTP id
 a92af1059eb24-1384baef0eamr614232c88.2.1781244237568; Thu, 11 Jun 2026
 23:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-6-kuniyu@google.com> <20260612003138.E67A01F00A3A@smtp.kernel.org>
In-Reply-To: <20260612003138.E67A01F00A3A@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:03:46 -0700
X-Gm-Features: AVVi8Cczhkg6FtQurw1RZf7Wbte6Zx7PIZp3NplQ_r9NgdxVKnA1DXiiKKGAc1E
Message-ID: <CAAVpQUCRU1ie22PbegWgGnfyWw9V0wSTjgQpw=5Wwb2RZ=su+w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 5/5] selftest: bpf: Add test for hwtstamp proxy.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] Comparing a potentially negative return value to `sizeof()` caus=
es failure handling to be skipped, erroneously dropping packets.
> - [Medium] Incorrect struct cast for SO_TIMESTAMPING_NEW cmsg data causes=
 test failures on 32-bit systems.
> - [Medium] Typo in the test assertion prevents verification of TX timesta=
mp keys.
> - [Low] Multi-line comments violate the BPF subsystem comment style.
> - [Low] The `buf_cmsg` array is not fully initialized before being passed=
 to `sendmsg()`, passing uninitialized stack data to the kernel.
> --
>
> commit e747f30190af013f6f5cc858f0dacb86e902e2d2
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> selftest: bpf: Add test for hwtstamp proxy.
>
> This selftest simulates the hardware timestamp proxy scenario using two
> UDP sockets, simulating a userspace proxy via a GENEVE device.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c b/=
tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
> > new file mode 100644
> > index 0000000000000..d0f90f22bea22
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
> [ ... ]
> > +char *ipv4_commands[] =3D {
> > +     "ip link set dev lo up",
> > +     "ip link add geneve0 type geneve local " APP_SRC_IPV4 " external"=
,
> > +     "ip addr add " APP_SRC_IPV4 "/24 dev geneve0",
> > +     "ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
> > +     "ip link set dev geneve0 up",
> > +     "ip route add " APP_DST_IPV4 "/32 dev geneve0",
> > +     /* We do not forward ARP to the wire in this test,
> > +      * so a static neighbour entry is needed for APP_DST_IPV4.
> > +      */
>
> [Severity: Low]
> Does this multi-line comment format violate the BPF subsystem comment sty=
le?
> It seems the subsystem guidelines prefer the opening /* on its own line f=
or
> multi-line comments.

Gray zone, this is rather net one :)

>
> > +     "ip neigh add " APP_DST_IPV4 " lladdr ab:bc:cd:de:ef:fa dev genev=
e0",
> > +};
> [ ... ]
> > +static int check_tstamp(struct proxy_hwtstamp_test_case *test_case, bo=
ol tx)
> > +{
> [ ... ]
> > +     for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&ms=
g, cmsg)) {
> > +             if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type=
 =3D=3D SO_TIMESTAMPING_NEW) {
> > +                     struct scm_timestamping *ts;
> > +
> > +                     ts =3D (struct scm_timestamping *)CMSG_DATA(cmsg)=
;
> > +                     ASSERT_EQ(ts->ts[2].tv_sec, 0, "tv_sec");
> > +                     ASSERT_EQ(ts->ts[2].tv_nsec, HWTSTAMP, "tv_nsec")=
;
>
> [Severity: Medium]
> Since the test requests SO_TIMESTAMPING_NEW, the kernel will return times=
tamps
> using the 64-bit time architecture (via struct scm_timestamping64). Could
> casting CMSG_DATA(cmsg) to struct scm_timestamping * cause issues on 32-b=
it
> architectures where time_t is 32-bit?

Indeed, I'll use scm_timestamping64 here.


>
> It looks like this might misalign the array access, reading the zeroed
> software timestamp ts[1] instead of the hardware timestamp, potentially
> causing the test to fail.
>
> > +
> > +                     saw_tstamp =3D true;
> > +             } else if ((cmsg->cmsg_level =3D=3D SOL_IP && cmsg->cmsg_=
type =3D=3D IP_RECVERR) ||
> > +                        (cmsg->cmsg_level =3D=3D SOL_IPV6 && cmsg->cms=
g_type =3D=3D IPV6_RECVERR)) {
> > +                     struct sock_extended_err *ee;
> > +
> > +                     ee =3D (struct sock_extended_err *)CMSG_DATA(cmsg=
);
> > +
> > +                     if (ee->ee_origin =3D=3D SO_EE_ORIGIN_TIMESTAMPIN=
G) {
> > +                             ASSERT_EQ(ee->ee_data, TSKEY, "tskey");
> > +                             saw_tskey =3D true;
> > +                     }
> > +             }
> > +     }
> > +
> > +     ASSERT_TRUE(saw_tstamp && (!tx || saw_tstamp), "no timestamp");
>
> [Severity: Medium]
> Should this check validate saw_tskey instead of checking saw_tstamp twice=
?

Yes, will update the latter check.


> It looks like if the kernel fails to deliver the timestamp key, this chec=
k
> will silently pass, potentially hiding regressions.
>
> > +
> > +     return ret;
> > +}
> > +
> > +static int test_proxy_hwtstamp_tx(struct proxy_hwtstamp_test_case *tes=
t_case)
> > +{
> > +     char h_source_dummy[ETH_HLEN] =3D {0xFF, 0xEE, 0xDD, 0xCC, 0xBB, =
0xAA};
> > +     char buf_cmsg[CMSG_SPACE(sizeof(u32))];
> > +     struct proxy_header *phdr;
> > +     struct msghdr msg =3D {};
> > +     struct iovec iov =3D {};
> > +     struct cmsghdr *cmsg;
> > +     int ret;
> > +
> > +     memset(test_case->app_payload, 0xAB, sizeof(test_case->app_payloa=
d));
> > +     iov.iov_base =3D test_case->app_payload;
> > +     iov.iov_len =3D sizeof(test_case->app_payload);
> > +
> > +     msg.msg_iov =3D &iov;
> > +     msg.msg_iovlen =3D 1;
> > +     msg.msg_control =3D buf_cmsg;
> > +     msg.msg_controllen =3D sizeof(buf_cmsg);
> > +
> > +     cmsg =3D CMSG_FIRSTHDR(&msg);
> > +     cmsg->cmsg_level =3D SOL_SOCKET;
> > +     cmsg->cmsg_type =3D SCM_TS_OPT_ID;
> > +     cmsg->cmsg_len =3D CMSG_LEN(sizeof(u32));
> > +     *(u32 *)CMSG_DATA(cmsg) =3D TSKEY;
> > +
> > +     ret =3D sendmsg(test_case->app_fd, &msg, 0);
>
> [Severity: Low]
> Is it possible that uninitialized stack memory from buf_cmsg is being pas=
sed
> to the kernel here?

No.  All fields are initialised here.

>
> Only the first CMSG_LEN bytes are initialized, but msg_controllen is set =
to
> the full CMSG_SPACE size which includes uninitialized alignment padding.
> Could this trigger MemorySanitizer warnings?
>
> > +     if (!ASSERT_EQ(ret, sizeof(test_case->app_payload), "send"))
> > +             return -1;
> [ ... ]
> > diff --git a/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c b/tools=
/testing/selftests/bpf/progs/proxy_hwtstamp.c
> > new file mode 100644
> > index 0000000000000..c15428e4c20f6
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
> [ ... ]
> > +SEC("tcx/egress")
> > +int proxy_hwtstamp_egress(struct __sk_buff *skb)
> > +{
> [ ... ]
> > +     kskb =3D bpf_cast_to_kern_ctx(skb);
> > +     shared_info =3D bpf_core_cast(kskb->head + kskb->end, struct skb_=
shared_info);
> > +     if (!shared_info->tx_flags) {
> > +             /* If TX tstamp is not needed, don't insert the GENEVE op=
tion.
> > +              * The proxy socket will see genevehdr.opt_len =3D=3D 0.
> > +              */
>
> [Severity: Low]
> Does this multi-line comment format violate the BPF subsystem comment sty=
le?
> It seems the subsystem guidelines prefer the opening /* on its own line f=
or
> multi-line comments.

Same.

>
> > +             goto pass;
> > +     }
> [ ... ]
> > +SEC("tcx/ingress")
> > +int proxy_hwtstamp_ingress(struct __sk_buff *skb)
> > +{
> > +     struct proxy_hwtstamp_opt opt;
> > +     struct bpf_tunnel_key key;
> > +     int ret;
> > +
> > +     /* Get the GENEVE header. */
> > +     ret =3D bpf_skb_get_tunnel_key(skb, &key, sizeof(key), tunnel_rx_=
flags);
> > +     if (ret < 0)
> > +             goto drop;
> > +
> > +     if (key.tunnel_id !=3D GENEVE_VNI)
> > +             goto drop;
> > +
> > +     /* Get the GENEVE option. */
> > +     ret =3D bpf_skb_get_tunnel_opt(skb, &opt, sizeof(opt));
> > +     if (ret < sizeof(opt)) {
>
> [Severity: High]
> Can this check drop packets without a GENEVE option?
>
> bpf_skb_get_tunnel_opt() returns a signed integer, but sizeof(opt) is
> unsigned. If the return value is negative (e.g., -ENOENT), it will be
> promoted to a large unsigned integer during the comparison.
>
> Would this cause ret < sizeof(opt) to evaluate to false and skip the fail=
ure
> handling, inadvertently dropping legitimate traffic?

Ugh, I'll cast sizeof() to int.


>
> > +              /* If TX/RX tstamp is not needed, the proxy socket
> > +               * does not insert the GENEVE option.
> > +               */
> > +             goto pass;
> > +     }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612001803.23=
341-1-kuniyu@google.com?part=3D5
