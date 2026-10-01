Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148B46F4A7;
	Thu,  1 Oct 2026 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898800; cv=none; b=o7lKtffRYEd++XLhzwIZLZtdCKK0HktR4RpiJCPxG1X6x8LnwiMDvZgduBzGQ7pZhGdg1KRxg9Vxg6xvnSvWV42/LalerkhXtc7LnJC0usxi61aQApiOpF6YHKDG9UAh5Qj2tdN6MEhRncXEXRsuw1KWTkiL7EzJkwW8DvWaSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898800; c=relaxed/simple;
	bh=LSgY2/ElBkwr2NgH9UkdqjkjhrlQdarGyEoXTH/L52s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLIUVjVzrOFXgj1LIP58+V+DOJ19tBx1JE2quu/pZQu+WkzIp7PAMhuNiAACwygsAVVwaVs7RQE3QoJfqtId95t24HglaCtcB58TWNMfL4f3MYpMktnPVhu+PSFFWKKd3QSUqqfTVmD6FqnTCcD/vOE1DFmtQYQUZ8ASk1mvpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LZIeHYKw; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LZIeHYKw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898798; x=1822434798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QWh7WO5PC2bAOdkQihfFEuP4RMYotjDLBielgsU+rRE=;
  b=LZIeHYKwcgz4MW7vAzJhxAmpxdwWJ78Hrp8aD/7CS/sWM15jMstQGPj/
   qf/M+6XfydqGi7kCQ6teBtNpVAU2xrGZ22lUanggH+nJzoGpJshPtpa5U
   lUujOHPfs5sh0NNzXpJBHcy64iW+n1T7v/xoR1KFTVbe1Jn1i+fpHFV9u
   QvJ7RMvpINX9n5qWHMXiFr7ZaHyngvMIkFa/kB9TzpQ+0WHiT2U8baGu6
   wjbpsHCBwlcJUYVW5FvRnbQ1FxRH0o3CTC56HkUT0yynqfUgGXSI9vyok
   4GMLsVAOVPDmHZHer4RwDp1br9tb/s/IlDWQAjLf5uv5X7QA6gSuOnsrp
   A==;
X-CSE-ConnectionGUID: 2wkExpmIQxSlMReYGCA0uQ==
X-CSE-MsgGUID: qrtFL7oPSpG2ya4d8CRJtw==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30219941"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:53:18 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:6735]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.137:2525] with esmtp (Farcaster)
 id 1592cf9d-a892-4678-9818-c6625385ab35; Thu, 1 Oct 2026 23:53:18 +0000 (UTC)
X-Farcaster-Flow-ID: 1592cf9d-a892-4678-9818-c6625385ab35
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:53:17 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:53:17 +0000
From: Jay Wang <wanjay@amazon.com>
To: <alan.maguire@oracle.com>
CC: <abuehaze@amazon.com>, <andrii@kernel.org>, <arnd@arndb.de>,
	<ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<doebel@amazon.de>, <eddyz87@gmail.com>, <jay.wang.upstream@gmail.com>,
	<jolsa@kernel.org>, <linux-kbuild@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
	<martin.lau@linux.dev>, <mcgrof@kernel.org>, <memxor@gmail.com>,
	<mpohlack@amazon.de>, <nathan@kernel.org>, <nsc@kernel.org>,
	<ojeda@kernel.org>, <petr.pavlu@suse.com>, <rust-for-linux@vger.kernel.org>,
	<samitolvanen@google.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 9/9] kbuild, bpf: allow building the vmlinux BTF as a module
Date: Thu, 1 Oct 2026 23:53:17 +0000
Message-ID: <20261001235317.7760-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <dbbb6cde-9889-4445-abf6-0486c380925d@oracle.com>
References: <dbbb6cde-9889-4445-abf6-0486c380925d@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 29/09/2026 19:25, Alan Maguire wrote:
> The idea is close to what you had; we have a .BTF.link / .BTF.inline.link ELF section which consists of:
>
> #define BTF_LINK_SHA256_LEN    32
>
> /*
>  * A .BTF.link or .BTF.inline.link section identifies the module which
>  * carries a vmlinux BTF section.  The module name is NUL terminated and the
>  * field is padded to __MODULE_NAME_LEN.
>  */
> struct btf_link {
>        char module_name[__MODULE_NAME_LEN];
>        u8 sha256[BTF_LINK_SHA256_LEN];
>        u32 btf_size;
> } __packed;

Thanks, this works well for this series too, and it also covers both
points of your first mail.  v4 has it:
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

struct btf_link has this layout, and the kernel now takes the name of
the module to load from it: request_module() and the module notifier use
module_name instead of a hard-coded "btf_vmlinux" (patch 4/12).

> The link section is populated at the same time resolve_btfids populates the .BTF_ids section;
> we add support to resolve_btfids for a --btf_link option of the form
>
>     --btf_link <section>:<module>:<raw-btf-file>
>
> So in your case it will be
>
>     --btf_link .BTF:btf_vmlinux:vmlinux.BTF

That is what link-vmlinux.sh passes to the final --patch_btfids now,
with .tmp_vmlinux1.BTF as the file, which gen-btf.sh keeps for it with
=m (patch 12/12).  The printf code in gen-btf.sh is gone.

Filling the record in at the end also removed v3's placeholder object
for the first link: the zeroed record is now defined in C next to
struct btf_link, so it has its final size in every link, and the size
check in resolve_btfids also catches the kernel and the tool disagreeing
on the layout.

> resolve_btfids is written to support multiple --btf_link options, so whichever work lands
> first could add the support that the other series uses. Hope this helps,

Your patch is 10/12, without the inline BTF context, which I will
leave to a separate patch series later.  I reworded its subject and
changelog and made a few small changes, all listed in the bracketed
note above my Signed-off-by.  Please check that you are fine with it in
that form.

Tested with 32- and 64-bit, little- and big-endian objects, also with
two --btf_link options in one run, and on x86-64 and i386 =m kernels,
where .BTF.link matches the BTF in btf_vmlinux.ko.

Jay
