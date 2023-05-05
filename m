Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C3BE7A
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6EAC433D2;
	Fri,  5 May 2023 15:21:35 +0000 (UTC)
Date: Fri, 5 May 2023 11:21:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 01/11] fprobe: Pass return address to the handlers
Message-ID: <20230505112134.34669200@gandalf.local.home>
In-Reply-To: <168299384798.3242086.3958932989430895961.stgit@mhiramat.roam.corp.google.com>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
	<168299384798.3242086.3958932989430895961.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 May 2023 11:17:28 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Pass return address as 'ret_ip' to the fprobe entry and return handlers.

The change log tells us "what" but not "why".

-- Steve

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>
