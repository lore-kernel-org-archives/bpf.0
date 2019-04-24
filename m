Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C8CC282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFF6208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfDXStu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:49:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:2513 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDXStu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 14:49:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 11:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="gz'50?scan'50,208,50";a="167579543"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2019 11:48:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hJMwn-0007F2-SR; Thu, 25 Apr 2019 02:48:45 +0800
Date:   Thu, 25 Apr 2019 02:48:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, quentin.monnet@netronome.com,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
Message-ID: <201904250237.q9Slxr3I%lkp@intel.com>
References: <20190423232200.101627-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20190423232200.101627-1-sdf@google.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stanislav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Stanislav-Fomichev/bpf-support-BPF_PROG_QUERY-for-BPF_FLOW_DISSECTOR-attach_type/20190424-235216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: sparc64-allnoconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
All errors (new ones prefixed by >>):

   In file included from include/net/net_namespace.h:37:0,
                    from include/linux/inet.h:46,
                    from include/linux/sunrpc/msg_prot.h:204,
                    from include/linux/sunrpc/auth.h:16,
                    from include/linux/nfs_fs.h:31,
                    from arch/sparc//kernel/sys_sparc32.c:25:
>> include/linux/skbuff.h:1268:12: error: 'skb_flow_dissector_prog_query' defined but not used [-Werror=unused-function]
    static int skb_flow_dissector_prog_query(const union bpf_attr *attr,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/skb_flow_dissector_prog_query +1268 include/linux/skbuff.h

  1255	
  1256	void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
  1257				     const struct flow_dissector_key *key,
  1258				     unsigned int key_count);
  1259	
  1260	#ifdef CONFIG_NET
  1261	int skb_flow_dissector_prog_query(const union bpf_attr *attr,
  1262					  union bpf_attr __user *uattr);
  1263	int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
  1264					       struct bpf_prog *prog);
  1265	
  1266	int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr);
  1267	#else
> 1268	static int skb_flow_dissector_prog_query(const union bpf_attr *attr,
  1269						 union bpf_attr __user *uattr)
  1270	{
  1271		return -EOPNOTSUPP;
  1272	}
  1273	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi--
