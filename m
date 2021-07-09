Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16224C07E9C
	for <bpf@archiver.kernel.org>; Fri,  9 Jul 2021 01:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F023461467
	for <bpf@archiver.kernel.org>; Fri,  9 Jul 2021 01:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhGIBq7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Jul 2021 21:46:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:2871 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhGIBq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Jul 2021 21:46:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="207805072"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="207805072"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 18:44:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="458104930"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.178.170]) ([10.212.178.170])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 18:44:15 -0700
Subject: Re: [PATCH v2 5/6] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>
References: <20210707204249.3046665-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210707204249.3046665-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4h8SaVL_QGLv1DT0JuoyKmSBvxJQw0aamMuzarexaU7VA@mail.gmail.com>
 <24d8fd58-36c1-0e89-4142-28f29e2c434b@linux.intel.com>
 <CAPcyv4heA8gps2K_ckUV1gGJdjGeB+5dOSntS=TREEX5-0rtwQ@mail.gmail.com>
 <4972fc1a-1ffb-2b6d-e764-471210df96a3@linux.intel.com>
 <CAPcyv4gwsT4rJzemkofk6SP5cAp9=nr5T6vtu+i6wTbU91R_Bg@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <ca608162-2a48-0816-4302-c2a5b2766a7a@linux.intel.com>
Date:   Thu, 8 Jul 2021 18:44:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gwsT4rJzemkofk6SP5cAp9=nr5T6vtu+i6wTbU91R_Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> One allocation for the life of the driver that can have its direct map
> permissions changed rather than an allocation per-file descriptor and
> fragmenting the direct map.

The vmap() approach discussed in another mail will solve that.

-Andi


