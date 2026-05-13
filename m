Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB037701B;
	Wed, 13 May 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683680; cv=none; b=gR7Klnv4WHx+1jGRDWjCV7RoGZfmfw59QH01LxGk5VGRQPFlUNnVGCwJjWpQ8gC7eEBPGaFXvAsCZ0vpTVnDtYOj5B2ueBQ0g6u5sFyJpUiMqlwAUaC27ptslVYmiKetKhR/9rgKlrxtFKtL+W9T//TtFQgzUpCAGlSCCJLFtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683680; c=relaxed/simple;
	bh=dxrQTbUBbb+rZywBjqNkfu5Bhu+7sLPWrt7ECMrb4Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AP0QWqmNy/2YruQRb/NGcRCHoS+9qRWJduU9VwGBaQ3HhFKS3FDTwHDUAFmljJDMMGp4t2AJDh6gWEKYyTGSWU9ADFKp7Z8nTxUIju7nqElfxcOr2r7lF0lC0FyZBOFDynyhe6R1VrGY6URv/39w2JaneUEHIlXnAb/d1LeJba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 88AB71A0007;
	Wed, 13 May 2026 14:47:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 8F75232;
	Wed, 13 May 2026 14:47:55 +0000 (UTC)
Date: Wed, 13 May 2026 10:47:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, pengdonglin
 <pengdonglin@xiaomi.com>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: Re: [PATCH v4 2/3] fgraph: Enhance funcgraph-retval with BTF-based
 type-aware output
Message-ID: <20260513104758.6e64167e@gandalf.local.home>
In-Reply-To: <20251215034153.2367756-3-dolinux.peng@gmail.com>
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
	<20251215034153.2367756-3-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8F75232
X-Stat-Signature: 3wtuhhzzdgwgqr6kbfg3bp9hpoop1ua8
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+63wUQ1rDfHg1plWcdT8ZJRHI6ayT/iFE=
X-HE-Tag: 1778683675-92520
X-HE-Meta: U2FsdGVkX18+gGEu1iz9IKhoQIfVZbYq5gAbJom92dbhpALpTAqF7PwdQzj5wCWyBU7wSRT8b+bPALPwUhfqdQc7WaqPfzIKr7l9DjISSNPuRVgdQbuvBsL/gMUKoGl/H2SXFkHXSolhX03EfWyuejbKgZGT8iZb4jwFGLKDJIaGuPlwM1BlGeB4nt3RS3Zq2QoALLTqNGRahbpAOypiYT6OvzWzhSQJ3pUCUI583QwiAcuJo+jR28ZF2R339MmNO6Ca8ZOO/HiW0M9klSENDa2/AFJfbW9/620FfdhYHP+i9vHrwKb7Q3jJhIvmuqgnhEswZZjMCsDED80l1nS1dctYKZYSwFvdsT0kPZHoWh9nkQF1TkNDGqe6ySr5iM24m/n6QWPxETPY9uwwYgrBL2ypsu80JF6CKUKYShASPjcDQeiN5WD0vWICPgO51JKNv+mKNsdIwqQ=

On Mon, 15 Dec 2025 11:41:52 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> The current funcgraph-retval implementation suffers from two accuracy
> issues:
> 
> 1. Void-returning functions still print a return value, creating
>    misleading noise in the trace output.
> 
> 2. For functions returning narrower types (e.g., char, short), the
>    displayed value can be incorrect because high bits of the register
>    may contain undefined data.
> 
> This patch addresses both problems by leveraging BTF to obtain the exact
> return type of each traced kernel function. The key changes are:
> 
> 1. Void function filtering: Functions with void return type no longer
>    display any return value in the trace output, eliminating unnecessary
>    clutter.
> 
> 2. Type-aware value formatting: The return value is now properly truncated
>    to match the actual width of the return type before being displayed.
>    Additionally, the value is formatted according to its type for better
>    human readability.
> 
> Here is an output comparison:
> 
> Before:
>  # perf ftrace -G vfs_read --graph-opts retval
>  ...
>  1)               |   touch_atime() {
>  1)               |     atime_needs_update() {
>  1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
>  1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
>  1)               |       current_time() {
>  1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
>  1)   0.352 us    |       } /* current_time ret=0x69380753 */
>  1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
>  1)   0.937 us    |   } /* touch_atime ret=0x0 */
> 
> After:
>  # perf ftrace -G vfs_read --graph-opts retval
>  ...
>  2)               |   touch_atime() {
>  2)               |     atime_needs_update() {
>  2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
>  2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
>  2)               |       current_time() {
>  2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
>  2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
>  2)   0.753 us    |     } /* atime_needs_update ret=false */
>  2)   0.899 us    |   } /* touch_atime */
> 
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/trace/trace_functions_graph.c | 124 ++++++++++++++++++++++++---
>  1 file changed, 111 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 17c75cf2348e..46b66b1cfc16 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -15,6 +15,7 @@
>  
>  #include "trace.h"
>  #include "trace_output.h"
> +#include "trace_btf.h"
>  
>  /* When set, irq functions might be ignored */
>  static int ftrace_graph_skip_irqs;
> @@ -120,6 +121,13 @@ enum {
>  	FLAGS_FILL_END   = 3 << TRACE_GRAPH_PRINT_FILL_SHIFT,
>  };
>  
> +enum {
> +	RETVAL_FMT_HEX   = BIT(0),
> +	RETVAL_FMT_DEC   = BIT(1),
> +	RETVAL_FMT_BOOL  = BIT(2),
> +	RETVAL_FMT_TRUNC = BIT(3),
> +};
> +
>  static void
>  print_graph_duration(struct trace_array *tr, unsigned long long duration,
>  		     struct trace_seq *s, u32 flags);
> @@ -865,6 +873,73 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
>  
>  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
>  
> +static void trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
> +			int *fmt)

This function should really be in trace_btf.c and a stub when btf is not
enabled.

-- Steve

> +{
> +	const struct btf_type *t;
> +	char name[KSYM_NAME_LEN];
> +	struct btf *btf;
> +	u32 v, msb;
> +	int kind;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +		return;
> +
> +	if (lookup_symbol_name(func, name))
> +		return;
> +
> +	t = btf_find_func_proto(name, &btf);
> +	if (IS_ERR_OR_NULL(t))
> +		return;
> +
> +	t = btf_type_skip_modifiers(btf, t->type, NULL);
> +	kind = t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN;
> +	switch (kind) {
> +	case BTF_KIND_UNKN:
> +		*print_retval = false;
> +		break;
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +		if (kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION)
> +			*fmt = RETVAL_FMT_HEX;
> +		else
> +			*fmt = RETVAL_FMT_DEC;
> +
> +		if (t->size > sizeof(unsigned long)) {
> +			*fmt |= RETVAL_FMT_TRUNC;
> +		} else {
> +			msb = BITS_PER_BYTE * t->size - 1;
> +			*retval &= GENMASK(msb, 0);
> +		}
> +		break;
> +	case BTF_KIND_INT:
> +		v = *(u32 *)(t + 1);
> +		if (BTF_INT_ENCODING(v) == BTF_INT_BOOL) {
> +			*fmt = RETVAL_FMT_BOOL;
> +			msb = 0;
> +		} else {
> +			if (BTF_INT_ENCODING(v) == BTF_INT_SIGNED)
> +				*fmt = RETVAL_FMT_DEC;
> +			else
> +				*fmt = RETVAL_FMT_HEX;
> +
> +			if (t->size > sizeof(unsigned long)) {
> +				*fmt |= RETVAL_FMT_TRUNC;
> +				msb = BITS_PER_LONG - 1;
> +			} else {
> +				msb = BTF_INT_BITS(v) - 1;
> +			}
> +		}
> +		*retval &= GENMASK(msb, 0);
> +		break;
> +	default:
> +		*fmt = RETVAL_FMT_HEX;
> +		break;
> +	}
> +}
> +
