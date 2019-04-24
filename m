Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF6C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D928218B0
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 16:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfDXQbl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:31:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:17998 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbfDXQbl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 12:31:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 09:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="226315297"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2019 09:31:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hJKo6-0001oH-07; Thu, 25 Apr 2019 00:31:37 +0800
Date:   Thu, 25 Apr 2019 00:31:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     kbuild-all@01.org, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: Re: [PATCH v4 bpf-next 15/15] nfp: bpf: eliminate zero extension
 code-gen
Message-ID: <201904250050.Z0Q6veLQ%lkp@intel.com>
References: <1555349185-12508-16-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555349185-12508-16-git-send-email-jiong.wang@netronome.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Jiong-Wang/bpf-eliminate-zero-extensions-for-sub-register-writes/20190416-191711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/netronome/nfp/bpf/jit.c:2654:34: sparse: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned char [usertype] dst @@    got resunsigned char [usertype] dst @@
>> drivers/net/ethernet/netronome/nfp/bpf/jit.c:2654:34: sparse:    expected unsigned char [usertype] dst
>> drivers/net/ethernet/netronome/nfp/bpf/jit.c:2654:34: sparse:    got restricted swreg [usertype] dst
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:2680:34: sparse: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned char [usertype] dst @@    got resunsigned char [usertype] dst @@
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:2680:34: sparse:    expected unsigned char [usertype] dst
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:2680:34: sparse:    got restricted swreg [usertype] dst

vim +2654 drivers/net/ethernet/netronome/nfp/bpf/jit.c

  2627	
  2628	static int mem_ldx_skb(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
  2629			       u8 size)
  2630	{
  2631		swreg dst = reg_both(meta->insn.dst_reg * 2);
  2632	
  2633		switch (meta->insn.off) {
  2634		case offsetof(struct __sk_buff, len):
  2635			if (size != FIELD_SIZEOF(struct __sk_buff, len))
  2636				return -EOPNOTSUPP;
  2637			wrp_mov(nfp_prog, dst, plen_reg(nfp_prog));
  2638			break;
  2639		case offsetof(struct __sk_buff, data):
  2640			if (size != FIELD_SIZEOF(struct __sk_buff, data))
  2641				return -EOPNOTSUPP;
  2642			wrp_mov(nfp_prog, dst, pptr_reg(nfp_prog));
  2643			break;
  2644		case offsetof(struct __sk_buff, data_end):
  2645			if (size != FIELD_SIZEOF(struct __sk_buff, data_end))
  2646				return -EOPNOTSUPP;
  2647			emit_alu(nfp_prog, dst,
  2648				 plen_reg(nfp_prog), ALU_OP_ADD, pptr_reg(nfp_prog));
  2649			break;
  2650		default:
  2651			return -EOPNOTSUPP;
  2652		}
  2653	
> 2654		wrp_zext(nfp_prog, meta, dst);
  2655	
  2656		return 0;
  2657	}
  2658	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
