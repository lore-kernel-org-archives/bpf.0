Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8D3F0AAD;
	Thu, 28 May 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973367; cv=none; b=umVYvDrI3dkDuiewwtTTRfqLK1CHS1svotZQfJntG8W35p8XKlVBji1TjZBPhQnag355sN8yv+tlDxq95hl73TpaZhq38xs9BxVkXCEE6BOs1e78LTkap+9+YRYaMMOBOHPMRe36xSX+WBV9nhjclFFrZeeMu9ji+35qmmOFZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973367; c=relaxed/simple;
	bh=kFnZwLJ8xu+Alsl+DIKDuTDBI3mDcEVm87HStnOr/eA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVksQalvvLrlEoHMjkxgrMbEtfVrFXMZfLMZ1g+/QsH2V/ICq4Xd0edSJX74EjYzOQI0Fn3jGb2JQvA+Ig+/ktYrVV4RhCXy5TxWMVJoh1UH+LYkFS3C4A6FiA9ZKglp9CWMs6kCmRULj9d6Kg+dUXcI4o1TY4qKvbmRYe6b2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 97F471A0843;
	Thu, 28 May 2026 13:02:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id B154920031;
	Thu, 28 May 2026 13:02:33 +0000 (UTC)
Date: Thu, 28 May 2026 09:02:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Alexis =?UTF-8?B?TG90aG9yw6k=?= (eBPF Foundation)"
 <alexis.lothore@bootlin.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, ebpf@linuxfoundation.org, Bastien Curutchet
 <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH bpf-next] x86/ftrace: relocate %rip-relative percpu refs
 in dynamic trampolines
Message-ID: <20260528090231.45d9b28f@fedora>
In-Reply-To: <20260527211135.GA343181@noisy.programming.kicks-ass.net>
References: <20260527-fix_call_depth_in_trampoline-v1-1-1c1abc8ae310@bootlin.com>
	<20260527211135.GA343181@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B154920031
X-Stat-Signature: k5fthizrphcmmz9ker4h6n6ht9d3oein
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19s7um7IvRovKQEf0oL/41fxiy3v1uidis=
X-HE-Tag: 1779973353-99954
X-HE-Meta: U2FsdGVkX1/GxsH1/WrVEp0XGnEK7Hwnu5XKmajG387FwxA2T5i5h9Fs84meGs+LliVoYywO0ATvbbpj10smHn5SiDQXQrti23NZNzRyJZF4YphgYymExV5/qcwpH+QE3LtXP7k1WNlY6mWy39sXZwAIPMoD1SHGEuGU/r7VopMtXsKo1ojcKEMRXHVu+SNabNqI9y9nQamw1OKp02EGzSC+An0P1Xg1le6ktNpmPYYSUNMiAHw8SvAviSUVdwyWkCX45Q7jBw5EUmJ8BHVYIaue2jstpcnZo4KGcUG7CEUCm/8itneL1oxS4Sb/9xXyhHrUeWsTSA1NeUuo28myPiIUYM57lZBHSDruiV63ukyV9J4j4PkheztB9kEA5vFS

On Wed, 27 May 2026 23:11:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> I went and had a quick grep through the tree to see if there are more
> sites that were missed in the conversion (commit 17bce3b2ae2d), but I
> couldn't find another one.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Peter, do you want me to take this through my tree, or do you prefer it
goes through the x86 tree?

-- Steve
