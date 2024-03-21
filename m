Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064512BE89
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056367; cv=none; b=e3/WqTrid/NjrpyavGtPqP+jrMROj1s6WZgECTHlIkJLfWnDhsD2wPhw4SjwsnZXaaVFc9OCsdjvWHEw5wjXrAzPyUqIXcte1ZvFuOlQKWG0oAFAcIaanlCL/vmAv1Ienj63m6Jd41RUsDO2nCY3OxEf0Ao0Hluz3c1xO5ydqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056367; c=relaxed/simple;
	bh=gWQoCRsjiZkFlFBTMJ4VIMlmbttTLiVikiLnnafWAnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe/lFxLmRUQT+xtPKGrj7BpOHQaebdBlH+iFbCXfA/nR3cvW2O2oATehOVvCwTbpilnLh6l2mfgfqNI1RUH1ctcqUt3azs81BbV1Q4vMQe6J7Zc4SZ+UeDpuUnfVLkXA8nQLh7YdPibawU335E5xM44SuaDcR1QbJFKINYK2Si0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hp/YhN9p; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hp/YhN9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711056365; x=1742592365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWQoCRsjiZkFlFBTMJ4VIMlmbttTLiVikiLnnafWAnQ=;
  b=hp/YhN9p/r6178Ld37DkeIVQbRgmsWsiwpPpQ8MYv6vMo9EsBAeiqPDS
   NYck5JFJlW5NuzqhFCl/1c9i+rJuVASliME6Abhk6vVlYAcqniBektyHT
   Jwxhw2CMx8lZDvRKvgYoc+j9aJXhica0QEWkfOQRAGHSHdRccziY7ij9e
   hgB6ReIyGcXkdZ5bvD4KiM7Mm6zjEP6Fl/DfGMyJVzxmEATX82VxzCfz4
   FO3qSsTsnku/uu4dK3MH6v3/IPsyU5F/hoxwzhWULg3PrA0ldjXeGxG4Y
   R41hC6H57nsRaFTrgkyxXxYf4TjrAU81/B6VJOdRfepoPWV14gXNENpLB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="23574066"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="23574066"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:26:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="19387166"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Mar 2024 14:26:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnPvD-000Jmt-04;
	Thu, 21 Mar 2024 21:25:59 +0000
Date: Fri, 22 Mar 2024 05:25:55 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Message-ID: <202403220545.KEzjr9hI-lkp@intel.com>
References: <20240319175406.2940628-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319175406.2940628-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Add-bpf_link-support-for-sk_msg-and-sk_skb-progs/20240320-015917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240319175406.2940628-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and sk_skb progs
config: nios2-randconfig-001-20240321 (https://download.01.org/0day-ci/archive/20240322/202403220545.KEzjr9hI-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403220545.KEzjr9hI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403220545.KEzjr9hI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/core/skmsg.c: In function 'bpf_sk_msg_skb_link_release':
>> net/core/skmsg.c:1279:23: error: implicit declaration of function 'sock_map_prog_update' [-Werror=implicit-function-declaration]
    1279 |                 (void)sock_map_prog_update(sk_link->map, NULL, link->prog,
         |                       ^~~~~~~~~~~~~~~~~~~~
>> net/core/skmsg.c:1281:17: error: implicit declaration of function 'bpf_map_put_with_uref' [-Werror=implicit-function-declaration]
    1281 |                 bpf_map_put_with_uref(sk_link->map);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   net/core/skmsg.c: At top level:
>> net/core/skmsg.c:1371:5: warning: no previous prototype for 'bpf_sk_msg_skb_link_create' [-Wmissing-prototypes]
    1371 | int bpf_sk_msg_skb_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/skmsg.c: In function 'bpf_sk_msg_skb_link_create':
>> net/core/skmsg.c:1383:15: error: implicit declaration of function 'bpf_map_get_with_uref' [-Werror=implicit-function-declaration]
    1383 |         map = bpf_map_get_with_uref(attr->link_create.target_fd);
         |               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/skmsg.c:1383:13: warning: assignment to 'struct bpf_map *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1383 |         map = bpf_map_get_with_uref(attr->link_create.target_fd);
         |             ^
   cc1: some warnings being treated as errors


vim +/sock_map_prog_update +1279 net/core/skmsg.c

  1272	
  1273	static void bpf_sk_msg_skb_link_release(struct bpf_link *link)
  1274	{
  1275		struct bpf_sk_msg_skb_link *sk_link = bpf_sk_msg_skb_link(link);
  1276	
  1277		mutex_lock(&link_mutex);
  1278		if (sk_link->map) {
> 1279			(void)sock_map_prog_update(sk_link->map, NULL, link->prog,
  1280						   sk_link->attach_type);
> 1281			bpf_map_put_with_uref(sk_link->map);
  1282			sk_link->map = NULL;
  1283		}
  1284		mutex_unlock(&link_mutex);
  1285	}
  1286	
  1287	static int bpf_sk_msg_skb_link_detach(struct bpf_link *link)
  1288	{
  1289		bpf_sk_msg_skb_link_release(link);
  1290		return 0;
  1291	}
  1292	
  1293	static void bpf_sk_msg_skb_link_dealloc(struct bpf_link *link)
  1294	{
  1295		kfree(bpf_sk_msg_skb_link(link));
  1296	}
  1297	
  1298	static int bpf_sk_msg_skb_link_update_prog(struct bpf_link *link,
  1299						   struct bpf_prog *new_prog,
  1300						   struct bpf_prog *old_prog)
  1301	{
  1302		const struct bpf_sk_msg_skb_link *sk_link = bpf_sk_msg_skb_link(link);
  1303		int ret = 0;
  1304	
  1305		mutex_lock(&link_mutex);
  1306		if (old_prog && link->prog != old_prog) {
  1307			ret = -EPERM;
  1308			goto out;
  1309		}
  1310	
  1311		if (link->prog->type != new_prog->type) {
  1312			ret = -EINVAL;
  1313			goto out;
  1314		}
  1315	
  1316		ret = sock_map_prog_update(sk_link->map, new_prog, old_prog,
  1317					   sk_link->attach_type);
  1318		if (!ret)
  1319			bpf_prog_inc(new_prog);
  1320	
  1321	out:
  1322		mutex_unlock(&link_mutex);
  1323		return ret;
  1324	}
  1325	
  1326	static int bpf_sk_msg_skb_link_fill_info(const struct bpf_link *link,
  1327						 struct bpf_link_info *info)
  1328	{
  1329		const struct bpf_sk_msg_skb_link *sk_link = bpf_sk_msg_skb_link(link);
  1330		u32 map_id = 0;
  1331	
  1332		mutex_lock(&link_mutex);
  1333		if (sk_link->map)
  1334			map_id = sk_link->map->id;
  1335		mutex_unlock(&link_mutex);
  1336	
  1337		if (link->type == BPF_LINK_TYPE_SK_MSG) {
  1338			info->skmsg.map_id = map_id;
  1339			info->skmsg.attach_type = sk_link->attach_type;
  1340		} else {
  1341			info->skskb.map_id = map_id;
  1342			info->skskb.attach_type = sk_link->attach_type;
  1343		}
  1344		return 0;
  1345	}
  1346	
  1347	static void bpf_sk_msg_skb_link_show_fdinfo(const struct bpf_link *link,
  1348						    struct seq_file *seq)
  1349	{
  1350		const struct bpf_sk_msg_skb_link *sk_link = bpf_sk_msg_skb_link(link);
  1351		u32 map_id = 0;
  1352	
  1353		mutex_lock(&link_mutex);
  1354		if (sk_link->map)
  1355			map_id = sk_link->map->id;
  1356		mutex_unlock(&link_mutex);
  1357	
  1358		seq_printf(seq, "map_id:\t%u\n", map_id);
  1359		seq_printf(seq, "attach_type:\t%u (...)\n", sk_link->attach_type);
  1360	}
  1361	
  1362	static const struct bpf_link_ops bpf_sk_msg_skb_link_ops = {
  1363		.release = bpf_sk_msg_skb_link_release,
  1364		.dealloc = bpf_sk_msg_skb_link_dealloc,
  1365		.detach = bpf_sk_msg_skb_link_detach,
  1366		.update_prog = bpf_sk_msg_skb_link_update_prog,
  1367		.fill_link_info = bpf_sk_msg_skb_link_fill_info,
  1368		.show_fdinfo = bpf_sk_msg_skb_link_show_fdinfo,
  1369	};
  1370	
> 1371	int bpf_sk_msg_skb_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
  1372	{
  1373		struct bpf_link_primer link_primer;
  1374		struct bpf_sk_msg_skb_link *sk_link;
  1375		enum bpf_attach_type attach_type;
  1376		enum bpf_link_type link_type;
  1377		struct bpf_map *map;
  1378		int ret;
  1379	
  1380		if (attr->link_create.flags)
  1381			return -EINVAL;
  1382	
> 1383		map = bpf_map_get_with_uref(attr->link_create.target_fd);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
