Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677D1172D;
	Tue,  2 Jan 2024 14:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37727C433CB;
	Tue,  2 Jan 2024 14:30:02 +0000 (UTC)
Date: Tue, 2 Jan 2024 09:31:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: P K <pkopensrc@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: Unable to trace nf_nat function using kprobe with latest kernel
 6.1.66-1
Message-ID: <20240102093102.6a74566d@gandalf.local.home>
In-Reply-To: <CAL0j0DF-b9ye7TD3mB-BgHvJYCN61NB+QU8Qr25NvfEv0OjPAA@mail.gmail.com>
References: <CAL0j0DF-b9ye7TD3mB-BgHvJYCN61NB+QU8Qr25NvfEv0OjPAA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 11:23:54 +0530
P K <pkopensrc@gmail.com> wrote:

> Hi,
> 
> I am unable to trace nf_nat functions using kprobe with the latest kernel.
> Previously in kernel 6.1.55-1 it was working fine.
> Can someone please check if it's broken with the latest commit or  i
> have to use it differently?
> 

Note, attaching to kernel functions is never considered stable API and may
break at any kernel release.

Also, if the compiler decides to inline the function, and makes it no
longer visible in /proc/kallsyms then that too will cause this to break.

-- Steve


> Mentioned below are output:
> Kernel - 6.1.55-1
> / # bpftrace -e 'kprobe:nf_nat_ipv4_manip_pkt { printf("func called\n"); }'
> Attaching 1 probe...
> cannot attach kprobe, probe entry may not exist
> ERROR: Error attaching probe: 'kprobe:nf_nat_ipv4_manip_pkt'
> 
> 
> 
> Kernel 6.1.55-1
> / # bpftrace -e 'kprobe:nf_nat_ipv4_manip_pkt { printf("func called\n"); }'
> Attaching 1 probe...
> func called
> func called

