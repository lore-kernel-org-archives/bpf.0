Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D097C43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C882063F
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 17:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCKR1c (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:27:32 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:36706 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727355AbfCKR1c (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Mar 2019 13:27:32 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 38C06A80070;
        Mon, 11 Mar 2019 17:27:31 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 10:27:27 -0700
Subject: Re: [PATCH bpf-next 1/2] btf: resolve enum fwds in btf_dedup
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "Alexei Starovoitov" <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
References: <20190311004410.3896503-1-andriin@fb.com>
 <20190311004410.3896503-2-andriin@fb.com>
 <755d4871-f8a1-ec31-02bf-87ffe82cdd56@fb.com>
 <CAEf4Bzbo1_mCN4wnGV+G8ombYPmSBNMQG7Qy8729Ji7HaKxV3Q@mail.gmail.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <4e224736-5174-17e5-f388-6c34276c0c24@solarflare.com>
Date:   Mon, 11 Mar 2019 17:27:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzbo1_mCN4wnGV+G8ombYPmSBNMQG7Qy8729Ji7HaKxV3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24482.005
X-TM-AS-Result: No-9.774700-4.000000-10
X-TMASE-MatchedRID: VfovoVrt/oYOwH4pD14DsPHkpkyUphL9h+w9Wz/xXDrVMpDytURQKLjb
        AjB47mUU2j/qBNnShPxLEH3d9KJSO0zKND1XrU3I6rBZUF8y6+hMkOX0Uoduucpj/9aYiP+hB2G
        XC4LTsCtD+7inobyEwzMKcoVeV58fEajRPsXMC3BT46Ow+EhYOClayzmQ9QV0zsQ8iRVyD441Hc
        Jp3+cWzSElvjMMUpPQ3mTkliUkGwRcScrsSCUv6HV895e/Bd2JfrTt+hmA5bJFRkv0B4bwghUk7
        uJFybp8pNKpOMpTOQvSR2ouhnxhVb9ZdlL8eonaC24oEZ6SpSk6XEE7Yhw4FovMW/v1gCfbHEJj
        fd3GgMjizvzUe4WVN+UbTnoYxbM7JyiF2DPNWaM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.774700-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24482.005
X-MDID: 1552325252-jMob5LqU8cZP
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/03/19 16:34, Andrii Nakryiko wrote:
> The only thing we should consider is that enums can have different
> sizes. And enum size is part of enum's forward declaration. So unlike
> struct/union fwd, enum's fwd has extra info. I don't think it's
> possible to specify in C (enum is always 4 bytes),
Not always, see e.g. N1458 §6.7.2.2.4:
> Each enumerated type shall be compatible with char, a signed integer
> type, or an unsigned integer type. The choice of type is implementation-
> defined,¹²⁸⁾ but shall be capable of representing the values of all the
> members of the enumeration. [...]
The enumeration _constants_ have type int (§6.7.2.2.3), but the enum type
itself has implementation-defined size, per the above.
C doesn't allow to forward-declare enumerators (§6.7.2.3.3), nor even to
reference them from the enumerator-list in the declaration, since the
enumerator type is incomplete until the closing brace (§6.7.2.2.4).
Footnote 128 adds that "An implementation may delay the choice of which
integer type until all enumeration constants have been seen."
It appears, in any case, that no forward-declaration could be required in
BTF, since an enum type's BTF record does not reference other types.  With
something like
    enum foo {
        BAR = sizeof(enum foo *),
    };
which is not valid C thanks to §6.7.2.3.3 (but many compilers will accept
it, e.g. gcc without -pedantic), the BTF record would read
    kind=enum name_off=&"foo" vlen=1
        name_off=&"BAR" val=8
(assuming 64-bit) which does not require any forward-declaring.

I don't know about the C++ situation, though.

-Ed

PS: It's not really clear to me what the rationale for §6.7.2.3.3 is,
since all the problems with incomplete enum types also arise with other
incomplete types; why 'enum foo *' can't be treated like 'struct quux *'
I don't know.  But this isn't comp.std.c...
