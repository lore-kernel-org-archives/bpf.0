Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7964FECD3;
	Fri,  4 Sep 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539414; cv=none; b=uGgVSGPbswhnjpqJxzvCfFAFnDF1XbW3lFoH44qh03DvoHjUrA2c3QTnnjuygqQ2MI42HO3Eq/sokDt0ygYWXrYeFzdxR9HLCwMfTNuAezOG/ZwT8h+R3v15DFaCm//Epvr1iz5xkcktUoUsgb6QVHs58XKp54E8opuj84Poa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539414; c=relaxed/simple;
	bh=TXxtulEj8I0CB6Un45dWCWX/x1I/VebmxSfxyNoMKgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTbmA3uzFmGhhBhfoYfbEP86O1QK7AeHCRuBe14PMqH555I+8dufVHnEcwW//90yCUwen3BD2/t7sPYAmho+2S20wNPU5rNNZq4/4vggteoSX/gCLay4+yqte92KIMZW27AN1jtfRdCoINnkvksXybX+mp5M1E1eWcBArK07J1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=VOioYwo5; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="VOioYwo5"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5B0AD120134;
	Fri,  4 Sep 2026 16:30:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 0F9C218;
	Fri,  4 Sep 2026 16:30:02 +0000 (UTC)
Date: Fri, 4 Sep 2026 12:31:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Gabriele Monaco" <gmonaco@redhat.com>, "Nam Cao"
 <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
Message-ID: <20260904123108.1fa1d815@gandalf.local.home>
In-Reply-To: <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	<87se3sakgi.fsf@yellow.woof>
	<df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	<DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
	<eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
	<20260903090211.50d15220@gandalf.local.home>
	<CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
	<20260904074317.01b2c0e1@robin>
	<DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0F9C218
X-Stat-Signature: i3t6jwjjocy3by9p9t5ttg5q7p6wwnkk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/udEqlQ3DfV28hAfWdP9Q6Hcj2odL1m5g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=y5+ZcOiopCfkKRJx022RKf8Hjr7n9jWmU6NpW0k7akc=; b=VOioYwo5LSWjE//yjjC2XovpgVNriHV/OdtJ/oA0BEB+3TF2oC6fKtiPrTf7weTt8FPsAfwhb58HRu3s7hbFdP951AoLmtnRukLHeih3EVTAhliyLnd432Sf7Gd4LA4V3P+KQSAl0g2F2OQEtaZkolMzePUK75Ww4Ajt5hn9M3M=
X-HE-Tag: 1788539402-400731
X-HE-Meta: U2FsdGVkX1+RIKJGqaaRHhNIqF68av7jRYbgDurG8vV/0QagXQPWz1WnJ8lLYq9vQFmics/15u9hDM9jHCispwe3CjhY49+RKXjW5aGgkv21Pv0YMftvvyGnjuRsqzzeSzq1Rjs433t3CgeqZBCuK0OxTqOW3pLVb5dt4rKm3aI7MWLFG45GqBRO72xJsniGj8wnmMIXioUjpiGWv1ov4CqbAS8gw3S1Kdf061TSQbJTsBOsj8YLFjF+3T5GvZwbD2RBK0Dun7aG1oqGSMTpq15N0W1L2H1s8hHVjcteinyyWoNj8DPLbzaSbNa3WMldqa/QsV/soOiSH0x3vlbc9LoJlM1tIgxU

On Fri, 04 Sep 2026 09:16:28 -0700
"Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:

> You added a whole bunch of hardcoded "monitors". None of them were
> necessary. The whole RV is imo a waste of kernel code.
> All of that could have been done via existing bpf tracing functionality.
> One can delete kernel/trace/rv and do the same thing with bpf.
> So I'm strongly against bolting bpf to RV as yet another "monitor".
> It's a wrong design. Keep adding hard coded monitors and don't mess
> with bpf.

In the beginning, Daniel Bristot looked into doing this with BPF and found
issues with it. I do not recall what they were and unfortunately Daniel is
no longer around to explain it. Maybe Gabriele knows what they were.

> 
> > Gabriele will be presenting this work at Linux Plumbers[1]. This will  
> 
> I didn't vote for it. Other bpf maintainers did. Hence it's in schedule.
> But my stance is still a nack.

So be it, it will likely be a lively discussion ;-)

-- Steve
