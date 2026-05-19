Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904953559CA;
	Tue, 19 May 2026 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183364; cv=none; b=XuugxC1+eVc1BAfObqdSyoR0fM4zhtMIEuP+CtUzD6O0YgNILmW/Em+I0PeOArSz47MIHTaqQx4wY1zJzHM15WvSQQmKmngjQ84YS27waeSQpb+/QvNnm9otWdTjgmyE9mV3j1i6oDHUuI53mC+iz2mB8jenz5RiZhdgIEegtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183364; c=relaxed/simple;
	bh=+O6/+4T4awqeCS+R4Y2zAaqUrtQGqmS/duNO2M96Qog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbdp4QkNuNdGT9T42iKrnhyWtSKlGAz+sAmF8z+bEVNjd1nsGlNgxGPfe2XV8JOEvJ4hxMJU1wfi7nQ05jEERTao5Q5udLj2p36bS5HD8K0YV6yG+S+Tm9+N42QYKU3Z01nQidRcEFWYced4NnNChTnVyD46KcyMDI4zXg63WAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bne2o/D5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bne2o/D5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183361; x=1810719361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+O6/+4T4awqeCS+R4Y2zAaqUrtQGqmS/duNO2M96Qog=;
  b=Bne2o/D5FHoNUEyAusowUgZluUrAkGXc8EXX6FRkrrl6R37r2jaJYmA4
   cInWD3e4EcGp9I59F0ekLgS6pUXuLB/bmj00/Cn16mqiAVHnw+CPJmkcW
   FXhABAaoUNCohGrdGxJNqTkneOHIXUk8wc4M/c55+K2bNatdyw25oi4Ye
   nEUkfppe8/YQ60407am1yzqBJX0skQIr1TO4vHV+fI9leu0Wk4GnWtgik
   +MLnHcAdkPoEE3DnpZ/Rf03Cmuk3d9x8MyAI/Fx6YOrKhQWYgjuA2ZW8z
   3r6yMjk2RhZotbxbZu5DEvAMLa4o7RAycepBvLywCRGR8Ub7vSfNO9E8X
   w==;
X-CSE-ConnectionGUID: O5iu/A8tRES1xZSbPbAm4A==
X-CSE-MsgGUID: utGovdXhQNGoiUZ7jfbSRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80107382"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80107382"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:36:00 -0700
X-CSE-ConnectionGUID: X9A/yvksRVKB3ycNmg8PDQ==
X-CSE-MsgGUID: hK66tiYXTFKI3ZAnVfl9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244710648"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 19 May 2026 02:35:55 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPGrG-000000000o1-2v9d;
	Tue, 19 May 2026 09:35:35 +0000
Date: Tue, 19 May 2026 17:34:32 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	Tom Zanussi <zanussi@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>,
	"Subject:[PATCH v2]" <tracing/pr@web.codeaurora.org>
Subject: Re: [PATCH v4] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <202605191710.jVjifK67-lkp@intel.com>
References: <20260518232312.0c78f055@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518232312.0c78f055@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v7.1-rc4 next-20260518]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-probes-Allow-use-of-BTF-names-to-dereference-pointers/20260519-121930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260518232312.0c78f055%40gandalf.local.home
patch subject: [PATCH v4] tracing/probes: Allow use of BTF names to dereference pointers
config: sh-defconfig (https://download.01.org/0day-ci/archive/20260519/202605191710.jVjifK67-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260519/202605191710.jVjifK67-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605191710.jVjifK67-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_probe.c: In function 'parse_probe_arg':
>> kernel/trace/trace_probe.c:1289:23: error: implicit declaration of function 'query_btf_struct' [-Wimplicit-function-declaration]
    1289 |                 ret = query_btf_struct(arg + 1, ctx);
         |                       ^~~~~~~~~~~~~~~~


vim +/query_btf_struct +1289 kernel/trace/trace_probe.c

  1120	
  1121	/* Recursive argument parser */
  1122	static int
  1123	parse_probe_arg(char *arg, const struct fetch_type *type,
  1124			struct fetch_insn **pcode, struct fetch_insn *end,
  1125			struct traceprobe_parse_context *ctx)
  1126	{
  1127		struct fetch_insn *code = *pcode;
  1128		unsigned long param;
  1129		int deref = FETCH_OP_DEREF;
  1130		long offset = 0;
  1131		char *tmp;
  1132		int ret = 0;
  1133	
  1134		switch (arg[0]) {
  1135		case '$':
  1136			ret = parse_probe_vars(arg, type, pcode, end, ctx);
  1137			break;
  1138	
  1139		case '%':	/* named register */
  1140			if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
  1141				/* eprobe and fprobe do not handle registers */
  1142				trace_probe_log_err(ctx->offset, BAD_VAR);
  1143				break;
  1144			}
  1145			ret = regs_query_register_offset(arg + 1);
  1146			if (ret >= 0) {
  1147				code->op = FETCH_OP_REG;
  1148				code->param = (unsigned int)ret;
  1149				ret = 0;
  1150			} else
  1151				trace_probe_log_err(ctx->offset, BAD_REG_NAME);
  1152			break;
  1153	
  1154		case '@':	/* memory, file-offset or symbol */
  1155			if (isdigit(arg[1])) {
  1156				ret = kstrtoul(arg + 1, 0, &param);
  1157				if (ret) {
  1158					trace_probe_log_err(ctx->offset, BAD_MEM_ADDR);
  1159					break;
  1160				}
  1161				/* load address */
  1162				code->op = FETCH_OP_IMM;
  1163				code->immediate = param;
  1164			} else if (arg[1] == '+') {
  1165				/* kprobes don't support file offsets */
  1166				if (ctx->flags & TPARG_FL_KERNEL) {
  1167					trace_probe_log_err(ctx->offset, FILE_ON_KPROBE);
  1168					return -EINVAL;
  1169				}
  1170				ret = kstrtol(arg + 2, 0, &offset);
  1171				if (ret) {
  1172					trace_probe_log_err(ctx->offset, BAD_FILE_OFFS);
  1173					break;
  1174				}
  1175	
  1176				code->op = FETCH_OP_FOFFS;
  1177				code->immediate = (unsigned long)offset;  // imm64?
  1178			} else {
  1179				/* uprobes don't support symbols */
  1180				if (!(ctx->flags & TPARG_FL_KERNEL)) {
  1181					trace_probe_log_err(ctx->offset, SYM_ON_UPROBE);
  1182					return -EINVAL;
  1183				}
  1184				/* Preserve symbol for updating */
  1185				code->op = FETCH_NOP_SYMBOL;
  1186				code->data = kstrdup(arg + 1, GFP_KERNEL);
  1187				if (!code->data)
  1188					return -ENOMEM;
  1189				if (++code == end) {
  1190					trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
  1191					return -EINVAL;
  1192				}
  1193				code->op = FETCH_OP_IMM;
  1194				code->immediate = 0;
  1195			}
  1196			/* These are fetching from memory */
  1197			if (++code == end) {
  1198				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
  1199				return -EINVAL;
  1200			}
  1201			*pcode = code;
  1202			code->op = FETCH_OP_DEREF;
  1203			code->offset = offset;
  1204			break;
  1205	
  1206		case '+':	/* deref memory */
  1207		case '-':
  1208			if (arg[1] == 'u') {
  1209				deref = FETCH_OP_UDEREF;
  1210				arg[1] = arg[0];
  1211				arg++;
  1212			}
  1213			if (arg[0] == '+')
  1214				arg++;	/* Skip '+', because kstrtol() rejects it. */
  1215			tmp = strchr(arg, '(');
  1216			if (!tmp) {
  1217				trace_probe_log_err(ctx->offset, DEREF_NEED_BRACE);
  1218				return -EINVAL;
  1219			}
  1220			*tmp = '\0';
  1221			ret = kstrtol(arg, 0, &offset);
  1222			if (ret) {
  1223				trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
  1224				break;
  1225			}
  1226			ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
  1227			arg = tmp + 1;
  1228			tmp = strrchr(arg, ')');
  1229			if (!tmp) {
  1230				trace_probe_log_err(ctx->offset + strlen(arg),
  1231						    DEREF_OPEN_BRACE);
  1232				return -EINVAL;
  1233			} else {
  1234				const struct fetch_type *t2 = find_fetch_type(NULL, ctx->flags);
  1235				int cur_offs = ctx->offset;
  1236	
  1237				*tmp = '\0';
  1238				ret = parse_probe_arg(arg, t2, &code, end, ctx);
  1239				if (ret)
  1240					break;
  1241				ctx->offset = cur_offs;
  1242				if (code->op == FETCH_OP_COMM ||
  1243				    code->op == FETCH_OP_DATA) {
  1244					trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
  1245					return -EINVAL;
  1246				}
  1247				if (++code == end) {
  1248					trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
  1249					return -EINVAL;
  1250				}
  1251				*pcode = code;
  1252	
  1253				code->op = deref;
  1254				code->offset = offset;
  1255				/* Reset the last type if used */
  1256				ctx->last_type = NULL;
  1257			}
  1258			break;
  1259		case '\\':	/* Immediate value */
  1260			if (arg[1] == '"') {	/* Immediate string */
  1261				ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
  1262				if (ret)
  1263					break;
  1264				code->op = FETCH_OP_DATA;
  1265				code->data = tmp;
  1266			} else {
  1267				ret = str_to_immediate(arg + 1, &code->immediate);
  1268				if (ret)
  1269					trace_probe_log_err(ctx->offset + 1, BAD_IMM);
  1270				else
  1271					code->op = FETCH_OP_IMM;
  1272			}
  1273			break;
  1274		case '(':
  1275			tmp = strrchr(arg, ')');
  1276			if (!tmp) {
  1277				trace_probe_log_err(ctx->offset + strlen(arg),
  1278						    DEREF_OPEN_BRACE);
  1279				return -EINVAL;
  1280			}
  1281	
  1282			tmp--;
  1283			if (*tmp != '*') {
  1284				trace_probe_log_err(ctx->offset + (tmp - arg),
  1285						    NO_PTR_STRCT);
  1286				return -EINVAL;
  1287			}
  1288			*tmp = '\0';
> 1289			ret = query_btf_struct(arg + 1, ctx);
  1290			*tmp = '*';
  1291	
  1292			if (ret < 0) {
  1293				trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
  1294				return -EINVAL;
  1295			}
  1296	
  1297			ctx->flags |= TPARG_FL_STRUCT;
  1298			tmp += 2;
  1299	
  1300			if (*tmp != '$') {
  1301				trace_probe_log_err(ctx->offset + (tmp - arg),
  1302						    BAD_VAR);
  1303				return -EINVAL;
  1304			}
  1305	
  1306			ctx->offset += tmp - arg;
  1307			ret = parse_probe_vars(tmp, type, pcode, end, ctx);
  1308			ctx->flags &= ~TPARG_FL_STRUCT;
  1309			ctx->last_struct = NULL;
  1310			break;
  1311		default:
  1312			if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
  1313				if (!tparg_is_function_entry(ctx->flags) &&
  1314				    !tparg_is_function_return(ctx->flags)) {
  1315					trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
  1316					return -EINVAL;
  1317				}
  1318				ret = parse_btf_arg(arg, pcode, end, ctx);
  1319				break;
  1320			}
  1321		}
  1322		if (!ret && code->op == FETCH_OP_NOP) {
  1323			/* Parsed, but do not find fetch method */
  1324			trace_probe_log_err(ctx->offset, BAD_FETCH_ARG);
  1325			ret = -EINVAL;
  1326		}
  1327		return ret;
  1328	}
  1329	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
