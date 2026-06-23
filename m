Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65730BF69;
	Tue, 23 Jun 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236068; cv=none; b=WvAdCfT/Y+DqL73zvPyJF2uW3uEFYAJeOIlSTvSLFVAag8ZfmEYNiEA9unZApGc95bAxmWSaZmixbrVP9gw7PimxDAvfvZdUKDf8EF0/elNwJ1GgW6XSN7ati+7Foe7AplHnGysyx6AhWO9d5WdTXZePNBUSqICVYfNoemu3zJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236068; c=relaxed/simple;
	bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEl58yX2sd6i7SztHdNlA79WI3bjUzwvWwtrVzrqHDIMoLHKLbjNsUGeGuaGHYvjxSEvzFLWkxIM0b66GKGJoS2JbZLDUBgEJqMDFLxaMmm5D4++S199v7UNpafNNtK+63ONqtEmGaIxnXvJriu4/m2Oost2mdSIcamfDJ6ERd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jH/sg/32; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jH/sg/32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782236067; x=1813772067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
  b=jH/sg/32qssJVc2slRAADa9uJoTxurohvvh6xGvk3rxpoEFe5z4aCfM2
   WDqZlOSluqUfrUUYyqsYRIZVmIseMdwGrpVaKY8+m316h3G9P5gUKvzkG
   2084DjHDEkbLEl98lW7BGWXZNQtpjC70UkPkJtBoqXTDVK4Agvxla02rM
   ZZXwNJYBcw5gpQpnutLtFIQhNiHLMxJ90Sewim7nl4nPwYJGIl4LbrnRY
   6Zuki8LXtMYx4E9wfLpjT20QEWp+FX2IdFmAHTKJpCtv7Q3R/9rYhzFSA
   ANFSgQM1bQfbQ5O2MpFMf+9DGKW3YsdQn82NSOxIp/1c/pj95Lp7f+RYJ
   g==;
X-CSE-ConnectionGUID: ohOXgrVxQJ6QeFVgsbFmjQ==
X-CSE-MsgGUID: o6V9ijYFQXeiWtL1+szp+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100414944"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100414944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:34:26 -0700
X-CSE-ConnectionGUID: 6wSkGP6/Sau1gn3LkRf6RQ==
X-CSE-MsgGUID: bDL9NoYfQhOpSnvbLMl24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249687588"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:34:27 -0700
Date: Tue, 23 Jun 2026 10:34:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v12 07/12] static_call: Define
 EXPORT_STATIC_CALL_FOR_MODULES()
Message-ID: <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>

There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
restrict symbol visibility to only certain modules.

Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
set of modules to see and update the static key.

The immediate user is KVM, in the following commit.

checkpatch reported below warnings with this change that I believe don't
apply in this case:

  include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
  include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 include/linux/static_call.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..b610afd1ed55 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -216,6 +216,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -276,6 +279,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 

-- 
2.34.1


