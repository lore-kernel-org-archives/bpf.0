Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E73BC282CE
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 14:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C3206B7
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TnMOHfEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfDKOcp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:32:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40767 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKOco (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 10:32:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so7666246wre.7
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jsubkmzz7caNrCn+b0CV84uY7+SgJfANd+KbZk6ctX4=;
        b=TnMOHfEtQyCqwNpGA8v79Bee2+TYodtd9zAkwtLEjGgzObvcTAhISPXTQ2bi3zBKf7
         YShGXk77oQsix0BkrzBUaECzLN90zL1E6Rvb4vDMI8i04TExI72mqNkntli+n6NCnPYg
         qi68jBkPhMZDPhAsMj9cthk36LfUVAXMWQ40x7OLlxULSZVkoaRNw52tzkCFqnmd30PS
         We0OD6J6ZQHaCA6rMyYDKYVURBZpdKvK/1tKPhx6Ulh4A8h596PqVmG34mVB9W3nZQTO
         9EhlL7WolVtflcJs3F0wWqiYtLG58IlDRpeXzgcXO2LS9S0foQNYGT+4MgVJKHa/jI9e
         g6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jsubkmzz7caNrCn+b0CV84uY7+SgJfANd+KbZk6ctX4=;
        b=WzWGqb2VEdFLcyql7InvP426weQIYehwLyU88I4kL+7qu2+iGI5Gne4PefJjIySBFf
         QiOf10DqTLXoJIv0U0zAGhyL2K81xnMgP6vso6kMLNz2LsGGmqkG/okMIZJEjMU8JP4C
         paQjm023j/OFaGsEIqO2V2MtYQOllOI9ho2e+qV2HCi5teAsk8OgG8cLH6jPP/f8EggE
         9V7t8+edxQH0zqBesbNBwEl1SVP8UlOaXGbbiw4kGYQ2TqpXV3fMEeA6hlaBsAPiFNdo
         McSwUK+nLxgN/z3WzED5dG4iDk3KMzVz7JOdoPO0uFhGgnQCD6sqjwAeiEUTH7djzwGV
         S2/g==
X-Gm-Message-State: APjAAAX44M7d1AMKss1qoWyB3Sc24IkmM8y09L4UxkjWvxJNOFat/SqT
        xvtIkDTb75yvHanRFn/2mF69HA==
X-Google-Smtp-Source: APXvYqyDSi/LQcbvPGkOIweI2pXmoGNSISUteZryMQMgl5jnf8vhZOK/QOt9icfg3CGCEpeNR43WEw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr5782311wrm.300.1554993158178;
        Thu, 11 Apr 2019 07:32:38 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id o5sm5685821wmc.16.2019.04.11.07.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 07:32:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC v2 bpf-next 11/19] libbpf: new global variable
 "libbpf_test_mode"
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190410201913.44dbf536@cakuba.netronome.com>
Date:   Thu, 11 Apr 2019 15:32:37 +0100
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECEC6F69-18BE-43C8-A5A7-818631F98D52@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
 <1554925833-7333-12-git-send-email-jiong.wang@netronome.com>
 <20190410201913.44dbf536@cakuba.netronome.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 11 Apr 2019, at 04:19, Jakub Kicinski =
<jakub.kicinski@netronome.com> wrote:
>=20
> On Wed, 10 Apr 2019 20:50:25 +0100, Jiong Wang wrote:
>> Enable BPF_F_TEST_RND_HI32 for all existing bpf selftests or other
>> independent tests could involve quite a few changes to make sure all =
bpf
>> prog load places has BPF_F_TEST_RND_HI32 set.
>>=20
>> Given most of the tests are using libbpf, this patch introduces a new
>> global variable "libbpf_test_mode" into libbpf, once which is set, =
all bpf
>> prog load issued through libbpf will have BPF_F_TEST_RND_HI32 set
>> automatically, this could minimize changes required from testsuite.
>>=20
>> The other way might be introducing new load function like
>> "bpf_prog_test_load", which will set BPF_F_TEST_RND_HI32. But there =
are
>> several prog load APIs, and we need minor changes on some parameters.
>>=20
>> The global variable approach seems to be a proper first step for easy
>> testsuite porting.
>>=20
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>=20
> Can we perhaps make it per-object by setting it after
> bpf_object__open() but before bpf_object__load(), or add=20
> it to struct bpf_object_open_attr?

Not sure I followed the meaning correctly. My read is you mean it would
better if there is more accurate and fine control on this feature, =
especially
if prog_flags could become an API parameter during file/obj/prog load?

As mentioned in the cover letter, I tried to implement =
bpf_prog_test_load
In parallel with existing bpf_prog_test_run, but then found there are
also similar APIs for bpf_object__open, and raw insn load =
=E2=80=9Cbpf_load_progams=E2=80=9D
etc and they may involve extending =
bpf_prog_load_attr/bpf_load_program_attr
etc. I thought the change is a little bit heavy. I could go further if =
it
is thought to be the correct way or there is any other suggestion on =
nicely
passing =E2=80=9Cprog_flags=E2=80=9D to low level bpf syscall in libbpf.

Regards,
Jiong=
