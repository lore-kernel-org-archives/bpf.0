Return-Path: <SRS0=Pk2X=ZP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F1C432C3
	for <bpf@archiver.kernel.org>; Sat, 23 Nov 2019 15:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4092070E
	for <bpf@archiver.kernel.org>; Sat, 23 Nov 2019 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKWPxG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Nov 2019 10:53:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:5303 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfKWPxG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 10:53:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2019 07:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,233,1571727600"; 
   d="scan'208";a="382378176"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2019 07:53:03 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iYXiY-000GMa-Ig; Sat, 23 Nov 2019 23:53:02 +0800
Date:   Sat, 23 Nov 2019 23:52:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     kbuild-all@lists.01.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        ecree@solarflare.com, thoiland@redhat.com,
        andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf-next 3/3] i40e: start using xdp_call.h
Message-ID: <201911232313.HpBmaWkp%lkp@intel.com>
References: <20191119160757.27714-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119160757.27714-4-bjorn.topel@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi "Björn,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on next-20191122]
[cannot apply to v5.4-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Bj-rn-T-pel/Introduce-xdp_call-h-and-the-BPF-dispatcher/20191120-074435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-36-g9305d48-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/i40e/i40e_main.c:5904:32: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/intel/i40e/i40e_main.c:5904:30: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [usertype] stat_counter_idx @@    got resunsigned short [usertype] stat_counter_idx @@
   drivers/net/ethernet/intel/i40e/i40e_main.c:5904:30: sparse:    expected unsigned short [usertype] stat_counter_idx
   drivers/net/ethernet/intel/i40e/i40e_main.c:5904:30: sparse:    got restricted __le16 [usertype]
   drivers/net/ethernet/intel/i40e/i40e_main.c:7564:29: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [assigned] [usertype] ipa @@    got ed int [assigned] [usertype] ipa @@
   drivers/net/ethernet/intel/i40e/i40e_main.c:7564:29: sparse:    expected unsigned int [assigned] [usertype] ipa
   drivers/net/ethernet/intel/i40e/i40e_main.c:7564:29: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/intel/i40e/i40e_main.c:7564:29: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [assigned] [usertype] ipa @@    got ed int [assigned] [usertype] ipa @@
   drivers/net/ethernet/intel/i40e/i40e_main.c:7564:29: sparse:    expected unsigned int [assigned] [usertype] ipa
   drivers/net/ethernet/intel/i40e/i40e_main.c:7564:29: sparse:    got restricted __le32 [usertype]
>> drivers/net/ethernet/intel/i40e/i40e_main.c:12521:1: sparse: sparse: symbol '____xdp_call_i40e_xdp_call_tramp' was not declared. Should it be static?
   arch/x86/include/asm/bitops.h:77:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)
   arch/x86/include/asm/bitops.h:77:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
