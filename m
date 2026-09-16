Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E83DB970;
	Wed, 16 Sep 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560445; cv=none; b=I4q92CncmwHxFwJHX5gmat8ja/3aUzLcv6x3VEGZoVGsDmrtgnhjTr6DUygHn3ffjJiBtLEEPalYW2T17ynedLHyt54q3QIVx0CWtwZAfogFHXWcnDZ6Z5wnNiv11YxA8bEn2Jag8QpILlk2RaXKK5+Xb0g5Mfb8Dg28ziQ1WmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560445; c=relaxed/simple;
	bh=E4nvLYul+RoTZh162BtA1GtFwhhlclEmreeYnC9hr0U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V+qsvdA++MxahD8RnZeDAWV2dPw07koVuFj4TTl4yE3HZRTijIRLbJecsBcyNUibjuWFrSiWKc42Y5elc77Nuv2JagPrWLUHkFXV6IAyJUhMO96vY4335JDqjyWHjCTgCS8j0kFAuaJ0V3VYvPFjzzmuGAxRasUMCPTRb7qiteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=OOnxuCBo; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="OOnxuCBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789560407; x=1790165207; i=t.fuechsel@gmx.de;
	bh=ZFqfeJhVsVQGDp3x1YwYVxTzf9UUYFMT/d2oDcLZ5ew=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OOnxuCBoaTPZt2I50YMHUuuK85HmfrXu/b1IJTcjGfsur/7xyDMTiHKBJ0spvZfU
	 a2RsMCk4meAbVnzKecuk8AS/nuVF8ZHIYDonQBxHgKJxIWoHiP5ZbA7x2NyxioZsm
	 Pl4mD1/ltjwuzBdEclTQFFTU3VxSFjJHeZ2n9Of8qTVGDW0+ATWckOGW4sYbX9MVV
	 TJt8SNFym4/Dhf0510ruFyuLf//aCOzH/kKSbhacQAYycYTD1m2TOV/s9sPfIeA7X
	 wUqOlA790MVj44U2Ffo+K8+9zIjf1q/BjB7WEl5sb1agdZGJy6T5Umn7EH29kwhs0
	 bNp0rA51367R6Owvmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv31c-1wp92E22qm-0127IN; Wed, 16
 Sep 2026 14:06:46 +0200
Date: Wed, 16 Sep 2026 14:06:43 +0200
From: Tim Fuechsel <t.fuechsel@gmx.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, fmancera@suse.de, ebiggers@kernel.org,
	bpf@vger.kernel.org,
	Lukas Prause <lukas.prause@ikt.uni-hannover.de>,
	Tim Fuechsel <t.fuechsel@gmx.de>
Subject: [PATCHv6 net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <aqqGU0XfcfsI-OGy@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sDUKsmR6RshRK274xgTz3wVACVYY9bmrcJI80oG34hJE0Uy91B/
 T/no7eOtAbR3UCwK5CCCt+HLf8QlvF5+AimKs5GoUACSMlIgJnzan1FeIVxFMybYTZixXA8
 VA34WDCfjwNccZ6FVIrcvduW+tlCKySfS4DPv+l+P8zOVWh+prPEO8r1LWW2fWcYGF71EUx
 TgRzORAf02yvvggBqs/FQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NCEWJ+QoYgA=;UorhGW3nognVx04V+gConD1WLyX
 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

TCP ROCCET is a new congestion control algorithm based on TCP CUBIC
that improves its overall performance in cellular networks. By its mode
of function, CUBIC causes bufferbloat while it tries to detect the
available throughput of a network path. This is particularly a problem
with large buffers in mobile networks. A more detailed description and
analysis of this problem caused by TCP CUBIC can be found in [1].
TCP ROCCET's main method of addressing the bufferbloat problem is by
adding two additional metrics. The first metric is the relative increase
in RTT from its minimum, the srRTT. Here, bufferbloat can be detected
when RTTs increase due to buffer filling. The second metric is the
acknowledgment arrival rate sampled over 100ms intervals and the bytes
sent and received over 5 RTTs. If CUBIC increases the send rate or
congestion window, and the acknowledgment arrival rate stays at the
same level, the connection is limited by the bottleneck link's capacity.
In such cases, ROCCET reduces the send rate to prevent bufferbloat.
ROCCET uses a modified version of slow start rather than HyStart because
HyStart is known to enter the congestion avoidance phase too early when
used in cellular networks [2]. Therefore, ROCCET uses a combination of
srRTT and the acknowledgment arrival rate to determine when to exit slow
start. For the congestion avoidance phase, ROCCET relies on the srRTT and
monitoring the sent and received bytes to detect the filling of the
bottleneck buffer. To keep the minimum RTT updated, ROCCET performs
minimum RTT probing if no new minimum RTT was found in the last 5 seconds.
To this end ROCCET halves the cwnd and probes for 200ms but at least for
one RTT, for a new minimum RTT. After probing, ROCCET refills the pipe
carefully. In addition, ROCCET reacts to packet loss by adapting CUBIC's
behavior. ECNs are handled as ROCCET congestion event, where the cwnd gets
reduced and ROCCET enters a buffer drain state.

In real-world mobile 5G NR measurements, TCP ROCCET achieves better
performance than CUBIC, by maintaining similar throughput while reducing
the latency. More information about TCP ROCCET and measurement evaluations
can be found here [3].
For the version (2026-07-21), we provide additional performance evaluation
regarding throughput, latency, and bandwidth share [4].

[1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
[2] https://doi.org/10.1109/WMNC.2016.7543932
[3] https://doi.org/10.23919/WONS68803.2026.11501781
[4] http://go.lu-h.de/roccet-2026-07-21

Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>

=2D--

Changes since v1:
	* Adjust some comments & Rework commit message
	* Fix Kconfig format
	* Add div-by-0 check variables
	* Fix ack summation from +=3D1 to +=3Dacked (counting now ACKs instead of=
 ACK events)
	* Fix wrapping in time comparisons
	* Remove most module_params, including 'ignore_loss'
	* Remove check that always evaluated to 'true' regarding 'bw_limit_detect=
'

Changes since v2:
	* Improve initialization of roccettcp struct
	* Always react to ECE bits and reset flag
	* Detect plateaus in ACK-rate
	* Fix potential overflow in ACK-rate tracking for high-speed connections
	* Reset ACK-counter correctly on new interval
	* Fix potential integer overflow in rRTT calculation

Changes since v3:
	* Changes in comments & Kconfig help text
	* Adjust commit message, adding reference to new performance evaluation
	* Add minimum RTT probing
	* Use cong_control callback instead of cong_avoid
	* Move CA_EVENT_TX_START event check to dedicated callback (cwnd_event_tx=
_start)
	* Add monitoring of send and receive rate as mentioned in the original pa=
per
	* Refactor of the code
	* Remove kfunc exports
	* Fix potential overflow in rRTT calculation by using 64-bit arithmetic
	* Fix potential division-by-zero in srRTT calculation due to RTT value
	* Initialize ack_rate timestamp to current time
	* Fix potential double penalty when receiving ECN (ECE) mark
	* Reset ack counting when connection goes idle
	* Add module-parameter bounds check on register

Changes since v4:
	* Remove __always_inline annotations & unused function
	* Fix module parameter bounds check desync
	* Add idle-check to fix connection freezing
	* Exchange .ssthresh callback from recalc_ssthresh to a ssthresh-getter, =
fixing double penalties
	* Remove unnecessary seq-no wrapping check & Remove 0 as 'uninitialized' =
seq-no value
	* Wait for first control round to finish before starting to monitor poten=
tial slow-start exit conditions

Changes since v5:
	* Complete refactor of the roccet-state-machine, improving maintainabilit=
y and robustness
	* Fix incorrect state transitions and state-exit conditions
	* Reconsider & fix handling of RTO, CWR and Recovery states
	* Fix module parameter usage & only re-calculate scaling factors on modul=
e-init
	* Fix usage of .ssthresh callback and use ssthresh more consciously
	* Fix incorrect coding-style
=2D--
 net/ipv4/Kconfig      |   12 +
 net/ipv4/Makefile     |    1 +
 net/ipv4/tcp_roccet.c | 1233 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1246 insertions(+)
 create mode 100644 net/ipv4/tcp_roccet.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 301b47660305..3545fb0a045b 100644
=2D-- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -663,6 +663,18 @@ config TCP_CONG_CDG
 	    delay gradients." In Networking 2011. Preprint:
 	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-prepri=
nt.pdf
=20
+config TCP_CONG_ROCCET
+	tristate "ROCCET TCP"
+	default n
+	help
+	  TCP ROCCET (RTT oriented CUBIC congestion control exTension) is a
+	  sender-side-only congestion control algorithm based on the TCP CUBIC
+	  protocol stack/TCP CUBIC congestion control algorithm that optimizes
+	  its performance. Especially for networks with large buffers
+	  (wireless, cellular networks), TCP ROCCET has improved performance by
+	  maintaining a similar throughput as CUBIC while reducing latency.
+	  For more information, see: https://arxiv.org/abs/2510.25281
+
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 06e21c26b76f..69e4baaed122 100644
=2D-- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_INET_TCP_DIAG) +=3D tcp_diag.o
 obj-$(CONFIG_INET_UDP_DIAG) +=3D udp_diag.o
 obj-$(CONFIG_INET_RAW_DIAG) +=3D raw_diag.o
 obj-$(CONFIG_TCP_CONG_BBR) +=3D tcp_bbr.o
+obj-$(CONFIG_TCP_CONG_ROCCET) +=3D tcp_roccet.o
 obj-$(CONFIG_TCP_CONG_BIC) +=3D tcp_bic.o
 obj-$(CONFIG_TCP_CONG_CDG) +=3D tcp_cdg.o
 obj-$(CONFIG_TCP_CONG_CUBIC) +=3D tcp_cubic.o
diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
new file mode 100644
index 000000000000..10ad4748d994
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,1233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
+ * Extension for 5G and Beyond Networks
+ *
+ * TCP ROCCET is a new TCP congestion control
+ * algorithm suited for current cellular 5G NR beyond networks.
+ * It extends the kernel default congestion control CUBIC
+ * and improves its performance, and additionally solves an
+ * unwanted side effects of CUBIC=E2=80=99s implementation.
+ * ROCCET uses its own Slow Start, called LAUNCH, where loss
+ * is not considered as a congestion event.
+ * The congestion avoidance phase, called ORBITER, uses
+ * CUBIC's window growth function and adds, based on RTT
+ * and ACK rate, congestion events.
+ *
+ * A peer-reviewed paper on TCP ROCCET will be presented
+ * at the WONS 2026 conference.
+ * A draft of the paper is available here:
+ *		https://arxiv.org/abs/2510.25281
+ *
+ *
+ * Further information about CUBIC:
+ * TCP CUBIC: Binary Increase Congestion control for TCP v2.3
+ * Home page:
+ *	http://netsrv.csc.ncsu.edu/twiki/bin/view/Main/BIC
+ * This is from the implementation of CUBIC TCP in
+ * Sangtae Ha, Injong Rhee and Lisong Xu,
+ *  "CUBIC: A New TCP-Friendly High-Speed TCP Variant"
+ *  in ACM SIGOPS Operating System Review, July 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/cubic_a_new_tcp_2008.pdf
+ *
+ * CUBIC integrates a new slow start algorithm, called HyStart.
+ * The details of HyStart are presented in
+ *  Sangtae Ha and Injong Rhee,
+ *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
+ *
+ * All testing results are available from:
+ * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
+ *
+ * Unless CUBIC is enabled and congestion window is large
+ * this behaves the same as the original Reno.
+ */
+
+#include <linux/time.h>
+#include <linux/printk.h>
+#include <linux/math64.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <net/tcp.h>
+
+/* Scale factor beta calculation (max_cwnd =3D snd_cwnd * beta) */
+#define BICTCP_BETA_SCALE 1024
+
+#define BICTCP_HZ 10 /* BIC HZ 2^10 =3D 1024 */
+
+/* Alpha value for the srRTT  multiplied by 100.
+ * Here 20 represents a value of 0.2
+ */
+#define ROCCET_ALPHA_TIMES_100 20
+
+/* min RTT probe period in ms */
+#define ROCCET_NEXT_MIN_RTT_PROBE 5000
+
+/* State in which roccet currently operates */
+enum roccet_state {
+	LAUNCH,
+	ORBITER,
+	RTT_PROBE_ENTER,
+	RTT_PROBE,
+	RTT_PROBE_REFILL,
+	DRAIN
+};
+
+/* TCP ROCCET struct based on the original BICTCP struct with
+ * additions specific to the ROCCET-Algorithm.
+ */
+struct roccettcp {
+	u32 cnt;	/* increase cwnd by 1 after ACKs */
+	u32 last_max_cwnd;	/* last maximum snd_cwnd */
+	u32 last_cwnd;	/* the last snd_cwnd */
+	u32 last_time;	/* time when updated last_cwnd */
+	u32 bic_origin_point;	/* origin point of bic function */
+	u32 bic_K;	/* time to origin point from the
+			 * beginning of the current epoch
+			 */
+	u32 delay_min;	/* min delay (usec) */
+	u32 epoch_start;	/* beginning of an epoch */
+	u32 ack_cnt;	/* number of acks */
+	u32 tcp_cwnd;	/* estimated tcp cwnd */
+	u32 curr_rtt;	/* last sample rtt of current round */
+
+	u32 roccet_last_event_time_us;	/* The last time ROCCET was triggered */
+	u32 curr_min_rtt;	/* The current observed minRTT */
+	u32 next_min_rtt_probe;	/* Next time to probe the minRTT */
+	u32 probe_min_rtt_until;	/* End of minRTT probing period.
+					 * Set while in RTT_PROBE states
+					 */
+	u32 refill_until;	/* End of pipe refill after minRTT probe.
+				 * Set while in RTT_PROBE states
+				 */
+	u32 cwnd_before_min_rtt_probe;	/* cwnd before min RTT probing. */
+	u32 curr_srrtt;	/* srRTT calculated based on the latest ACK */
+	u32 next_srrtt_check_ts;	/* Next check for srRTT */
+	u32 last_rtt;	/* sample rtt of previous round.
+			 * Used for jitter calculation
+			 */
+
+	u32 interval_snd_seq_start;
+	u32 interval_una_seq_start;
+
+	u32 ack_rate_last_rate_time;	/* Timestamp of the last ACK-rate */
+	u16 ack_rate_last_rate;	/* Last ACK-rate */
+	u16 ack_rate_curr_rate;	/* Current ACK-rate */
+	u16 ack_rate_cnt;	/* Used for counting acks */
+
+	enum roccet_state state : 3; /* Current operating state of roccet */
+	bool was_idle : 1;	/* Tracks whether the connection was idle
+				 * (had no in-flight packets)
+				 */
+	bool initial_limit_reached: 1;	/* Set to true after the connection
+					 * initially gets cwnd-limited
+					 */
+	bool is_in_initial_launch: 1;	/* true if the connection is in
+					 * the initial launch phase.
+					 */
+	u32 ack_carry_over;	/* Used to carry over leftover acks from
+				 * LAUNCH to ORBITER
+				 */
+};
+
+/* Parameters that are specific to the ROCCET-Algorithm */
+static uint sr_rtt_upper_bound __read_mostly =3D 100;
+static int ack_rate_diff_ss __read_mostly =3D 10;
+
+module_param(sr_rtt_upper_bound, uint, 0644);
+MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
+module_param(ack_rate_diff_ss, int, 0644);
+MODULE_PARM_DESC(ack_rate_diff_ss,
+		 "ROCCET's threshold to exit slow start if ACK-rate differs by given am=
ount of segments.");
+
+static int fast_convergence __read_mostly =3D 1;
+static int beta __read_mostly =3D 717; /* =3D 717/1024 (BICTCP_BETA_SCALE=
) */
+static int initial_ssthresh __read_mostly;
+static int bic_scale __read_mostly =3D 41;
+static int tcp_friendliness __read_mostly =3D 1;
+
+static u32 cube_rtt_scale __read_mostly;
+static u32 beta_scale __read_mostly;
+static u64 cube_factor __read_mostly;
+
+/* Note parameters that are used for precomputing scale factors are read-=
only */
+module_param(fast_convergence, int, 0644);
+MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
+module_param(beta, int, 0644);
+MODULE_PARM_DESC(beta, "beta for multiplicative increase");
+module_param(initial_ssthresh, int, 0644);
+MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold=
");
+module_param(bic_scale, int, 0444);
+MODULE_PARM_DESC(bic_scale,
+		 "scale (scaled by 1024) value for bic function (bic_scale/1024)");
+module_param(tcp_friendliness, int, 0644);
+MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
+
+/* Used to check certain roccet parameters used in `param_precompute` in =
order
+ * to avoid invalid scale-related calculations. This validates the specif=
ied
+ * parameters or rejects them.
+ */
+static int param_check(void)
+{
+	if (beta <=3D 0 || beta >=3D BICTCP_BETA_SCALE) {
+		pr_err_once("TCP ROCCET: beta must be between 0 and %d\n",
+			    BICTCP_BETA_SCALE);
+
+		return -EINVAL;
+	}
+
+	if (bic_scale <=3D 0) {
+		pr_err_once("TCP ROCCET: bic_scale must be positive\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Precompute some values based on the provided params.
+ * These are only precomputed during module initialization and are not up=
dated
+ * during runtime. Parameter changes at runtime will only affect the next=
 uses
+ * of the parameters, but not the precomputed values.
+ */
+static void param_precompute(void)
+{
+	/* Precompute a bunch of the scaling factors that are used per-packet
+	 * based on sRTT of 100ms.
+	 */
+	beta_scale =3D
+		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
+
+	cube_rtt_scale =3D (bic_scale * 10); /* 1024*c/rtt */
+
+	/* calculate the "K" for (wmax-cwnd) =3D c/rtt * K^3
+	 *  so K =3D cubic_root( (wmax-cwnd)*rtt/c )
+	 * the unit of K is bictcp_HZ=3D2^10, not HZ
+	 *
+	 *  c =3D bic_scale >> 10
+	 *  rtt =3D 100ms
+	 *
+	 * the following code has been designed and tested for
+	 * cwnd < 1 million packets
+	 * RTT < 100 seconds
+	 * HZ < 1,000,00  (corresponding to 10 nano-second)
+	 */
+
+	/* 1/c * 2^2*bictcp_HZ * srtt */
+	cube_factor =3D 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
+
+	/* divide by bic_scale and by constant srtt (100ms) */
+	do_div(cube_factor, bic_scale * 10);
+}
+
+static void roccet_reset(struct sock *sk, struct roccettcp *ca)
+{
+	memset(ca, 0, sizeof(struct roccettcp));
+	ca->next_srrtt_check_ts =3D 0;
+
+	/* Initialize all RTT values to U32_MAX, so that any lower samples
+	 * will be accepted.
+	 */
+	ca->curr_min_rtt =3D U32_MAX;
+	ca->curr_rtt =3D U32_MAX;
+	ca->last_rtt =3D U32_MAX;
+
+	ca->roccet_last_event_time_us =3D 0;
+	ca->ack_rate_last_rate =3D 0;
+
+	/* Initialize to current time to avoid an
+	 * overflow in the ack rate calculation
+	 */
+	ca->ack_rate_last_rate_time =3D jiffies_to_usecs(tcp_jiffies32);
+	ca->ack_rate_curr_rate =3D 0;
+	ca->ack_rate_cnt =3D 0;
+
+	ca->interval_snd_seq_start =3D tcp_sk(sk)->snd_nxt;
+	ca->interval_una_seq_start =3D tcp_sk(sk)->snd_una;
+
+	/* Start state is LAUNCH */
+	ca->state =3D LAUNCH;
+	ca->probe_min_rtt_until =3D 0;
+	ca->refill_until =3D 0;
+
+	ca->initial_limit_reached =3D false;
+	ca->is_in_initial_launch =3D false;
+}
+
+static void roccet_init(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	roccet_reset(sk, ca);
+
+	/* Reset here, so it is only set during init */
+	ca->is_in_initial_launch =3D true;
+
+	if (initial_ssthresh)
+		WRITE_ONCE(tcp_sk(sk)->snd_ssthresh, initial_ssthresh);
+
+	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
+}
+
+static void update_min_rtt(struct roccettcp *ca)
+{
+	/* Check if new lower min RTT was found. If so, set it directly.
+	 * If no valid RTT sample has been received yet, the check will fail,
+	 * since the rtt values are initialized to U32_MAX.
+	 */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
+		/* Probe for the min RTT in ROCCET_NEXT_MIN_RTT_PROBE ms
+		 * if no other update occurs.
+		 */
+		ca->next_min_rtt_probe =3D
+			jiffies_to_usecs(tcp_jiffies32) +
+			ROCCET_NEXT_MIN_RTT_PROBE * USEC_PER_MSEC;
+	}
+}
+
+/* Return difference between last and current ack rate.
+ */
+static s32 get_ack_rate_diff(struct roccettcp *ca)
+{
+	if (ca->ack_rate_curr_rate < ca->ack_rate_last_rate)
+		return 0;
+	return (s32)(ca->ack_rate_curr_rate - ca->ack_rate_last_rate);
+}
+
+/* Update ack rate sampled by 100ms.
+ */
+static void update_ack_rate(struct roccettcp *ca, u32 acked, u32 now)
+{
+	const s32 idle_threshold =3D USEC_PER_SEC * 2;
+	const s32 interval =3D USEC_PER_MSEC * 100;
+
+	s32 time_delta =3D (s32)(ca->ack_rate_last_rate_time - now);
+
+	/* Check if the time has arrived in the new interval.
+	 * Alternatively if the connection was considered to be idle,
+	 * also treat as a new interval in order to avoid timing-overflow
+	 * problems.
+	 */
+	if (time_delta < -interval || ca->was_idle) {
+		/* Check if the connection was idle for X seconds
+		 * (e.g. no ACK for X seconds)
+		 */
+		if (time_delta < -idle_threshold) {
+			/* Reset ack counting as if a new
+			 * connection was created
+			 */
+			ca->ack_rate_last_rate =3D 0;
+			ca->ack_rate_last_rate_time =3D
+				jiffies_to_usecs(tcp_jiffies32);
+			ca->ack_rate_curr_rate =3D 0;
+			ca->ack_rate_cnt =3D 0;
+		} else {
+			/* start counting for the new interval */
+			ca->ack_rate_last_rate_time =3D now;
+			ca->ack_rate_last_rate =3D ca->ack_rate_curr_rate;
+			ca->ack_rate_curr_rate =3D ca->ack_rate_cnt;
+			ca->ack_rate_cnt =3D min_t(u32, acked, U16_MAX);
+		}
+
+		ca->was_idle =3D false;
+	} else {
+		/* Cap the ack count to avoid overflow */
+		ca->ack_rate_cnt =3D min_t(u32, ca->ack_rate_cnt + acked,
+					 U16_MAX);
+	}
+}
+
+/* Compute srRTT.
+ */
+static void update_srrtt(struct roccettcp *ca)
+{
+	u64 rrtt;
+
+	/* Avoid integer overflow in the calculation below.
+	 * This could occur in cases where we have not yet
+	 * received an RTT sample after a min_rtt reset.
+	 * In these cases, set the rtt to a safe value.
+	 */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_rtt =3D max(ca->curr_rtt, 1);
+		ca->curr_min_rtt =3D ca->curr_rtt;
+	}
+
+	/* ca->curr_min_rtt can never be 0. For completeness, we check for this
+	 * anyways in order to avoid division by zero errors.
+	 */
+	if (ca->curr_min_rtt =3D=3D 0) {
+		pr_err_once("TCP ROCCET: Recorded curr_min_rtt is 0");
+		return; /* skip srRTT update */
+	}
+
+	/* Calculate the new rRTT (Scaled by 100).
+	 * 100 * ((sRTT - sRTT_min) / sRTT_min).
+	 *
+	 * curr_min_rtt is always <=3D than curr_rtt,
+	 * since this is the minimum of the rtt.
+	 *
+	 * 0 is a valid value for rrtt.
+	 *
+	 * If we have no valid RTT sample yet, curr_rtt and curr_min_rtt will
+	 * be U32_MAX. This ultimately results in no srrtt increase, which
+	 * is ok.
+	 */
+	rrtt =3D div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
+		       ca->curr_min_rtt);
+
+	/* (1 - alpha) * srRTT + alpha * rRTT */
+	ca->curr_srrtt =3D ((100 - ROCCET_ALPHA_TIMES_100) * (u64)ca->curr_srrtt=
 +
+			  ROCCET_ALPHA_TIMES_100 * rrtt) /
+			 100;
+}
+
+/* Handle ROCCET loss/ECN during min RTT probing.
+ */
+static void roccet_min_rtt_probe_ce(struct roccettcp *ca, u32 cwnd)
+{
+	/* This should only be called in RTT_PROBE state */
+	if (ca->state !=3D RTT_PROBE)
+		return;
+
+	/* If ROCCET is in min RTT probing and a loss/ECN occurs,
+	 * we use the cwnd before the probing interval to
+	 * calculate the cwnd reduction and continue probing.
+	 * After min RTT probing the cwnd is set to the reduced
+	 * value. During min RTT probing it is very likely that
+	 * congestion was caused by the cwnd value before min
+	 * RTT probing.
+	 */
+
+	if (ca->cwnd_before_min_rtt_probe =3D=3D 0)
+		pr_warn_once("ROCCET: cwnd_before_min_rtt_probe is 0 during RTT_PROBE. =
This should not happen.");
+	else
+		cwnd =3D ca->cwnd_before_min_rtt_probe;
+
+	ca->cwnd_before_min_rtt_probe =3D
+		max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+/* Do a ROCCET congestion event.
+ */
+static void roccet_congestion_event(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 curr_cwnd =3D tcp_snd_cwnd(tp);
+
+	ca->epoch_start =3D 0;
+	ca->roccet_last_event_time_us =3D now;
+
+	if (ca->state =3D=3D RTT_PROBE) {
+		/* In case we are in RTT_PROBE, continue with this state, as
+		 * the CE was likely caused by the cwnd before probing.
+		 * However do react to the CE.
+		 */
+		roccet_min_rtt_probe_ce(ca, curr_cwnd);
+		return;
+	}
+
+	ca->cnt =3D 100 * curr_cwnd;
+
+	/* Set W_max only if the current cwnd is larger */
+	if (ca->last_max_cwnd < curr_cwnd)
+		ca->last_max_cwnd =3D curr_cwnd;
+
+	/* Reduce cwnd by beta */
+	tcp_snd_cwnd_set(tp, min(tp->snd_cwnd_clamp,
+				 max((curr_cwnd * beta)
+				     / BICTCP_BETA_SCALE, 2U)));
+
+	if (ca->state =3D=3D LAUNCH) {
+		/* Set ssthresh on ECN, so that roccet is not in slow-start */
+		tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
+		ca->state =3D ORBITER;
+	} else if (ca->state =3D=3D ORBITER || ca->state =3D=3D RTT_PROBE_REFILL=
) {
+		/* If we are in orbiter or currently refilling the pipe,
+		 * abort the refill.
+		 */
+		ca->state =3D DRAIN;
+	}
+	/* Other states (e.g. DRAIN or RTT_PROBE_ENTER) not handled as
+	 * we don`t want any action there.
+	 */
+}
+
+static void roccet_enter_min_rtt_probe(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 interval, probe_cwnd;
+
+	/* If probing is already set, there was a mix up.
+	 * Continue anyway so we can recover.
+	 */
+	if (ca->probe_min_rtt_until > 0)
+		pr_warn_once("ROCCET: Probing time should not be set");
+
+	/* Safeguard for an "infinite" probe. This should logically never
+	 * happen but still safeguard it.
+	 */
+	if (ca->curr_rtt =3D=3D U32_MAX) {
+		pr_warn_once("ROCCET: curr_rtt is U32_MAX, cannot enter RTT_PROBE");
+		ca->state =3D ORBITER;
+		return;
+	}
+
+	/* Start min RTT probing */
+	/* Probe 1*RTT or at least 200ms */
+	interval =3D max(200 * USEC_PER_MSEC, ca->curr_rtt);
+
+	/* This is to handle deep shared buffers with loss-based
+	 * congestion control like CUBIC. If the cwnd is not limited
+	 * by the application but falsely detected (see ROCCET paper),
+	 * we have to empty the pipe more.
+	 * If the limit detection is correct this will cause no harm
+	 * to the tcp flow because the cwnd is not fully utilized and
+	 * we set the cwnd to its previous value after probing.
+	 */
+	if (!tcp_is_cwnd_limited(sk))
+		probe_cwnd =3D max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND);
+	else
+		probe_cwnd =3D max(tcp_snd_cwnd(tp) / 2, TCP_INIT_CWND);
+
+	ca->probe_min_rtt_until =3D now + interval;
+	ca->cwnd_before_min_rtt_probe =3D tcp_snd_cwnd(tp);
+
+	/* Half the cwnd to drain the buffer for probing. */
+	tcp_snd_cwnd_set(tp, probe_cwnd);
+
+	/* Reset current min RTT to allow probing for
+	 * a new lower and higher minimum RTT.
+	 */
+	ca->curr_min_rtt =3D U32_MAX;
+
+	/* Refill the pipe after probing.
+	 * For this we use the previous cwnd for another probing interval.
+	 */
+	ca->refill_until =3D ca->probe_min_rtt_until + interval;
+
+	/* Now we know that ca->probe_min_rtt_until < ca->refill_until
+	 * and we advance to the next state of the probing phase.
+	 *
+	 * Wrap-arounds of these values are handled by the relevant
+	 * if-conditions.
+	 */
+
+	ca->state =3D RTT_PROBE;
+}
+
+/* Do minimum RTT probing.
+ */
+static void roccet_min_rtt_probe(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Here we are in RTT_PROBE, so the probing time should be set.
+	 * If not just continue and enter refill phase.
+	 *
+	 * probe_min_rtt_until wrap-arounds are handled by the time_before32
+	 * check.
+	 */
+	if (ca->probe_min_rtt_until =3D=3D 0)
+		pr_warn_once("ROCCET: Probing time should be set");
+	else if (time_before32(now, ca->probe_min_rtt_until))
+		/* No state change if we are in the probing interval. */
+		return;
+
+	/* If the interval has passed we likely just entered the refill
+	 * interval, so go into RTT_PROBE_REFILL.
+	 * If we are not in the interval, something went wrong and we should
+	 * quickly exit the probing phase.
+	 *
+	 * Wraps-arounds of refill_until are caught by the time_after32 check.
+	 */
+	if (time_after32(now, ca->refill_until))
+		pr_warn_once("ROCCET: Skipped refill interval.");
+
+	/* Reset cwnd to refill the pipe and consequently clear the stored
+	 * window.
+	 * Also perform sanity check. THis should never happen.
+	 */
+	if (ca->cwnd_before_min_rtt_probe =3D=3D 0)
+		pr_warn_once("ROCCET: cwnd_before_min_rtt_probe is 0 during RTT_PROBE."=
);
+	else
+		tcp_snd_cwnd_set(tp, ca->cwnd_before_min_rtt_probe);
+
+	ca->cwnd_before_min_rtt_probe =3D 0;
+
+	/* Exit the RTT_PROBE state */
+	ca->state =3D RTT_PROBE_REFILL;
+}
+
+static void roccet_rtt_probe_refill(struct roccettcp *ca, u32 now)
+{
+	/* Once the refill interval is over, we can end the probing phase. */
+	if (time_after32(now, ca->refill_until)) {
+		/* End min RTT probing phase. */
+		ca->state =3D ORBITER;
+	}
+}
+
+static void roccet_cwnd_event_tx_start(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D tcp_jiffies32;
+	s32 delta;
+
+	delta =3D now - tcp_sk(sk)->lsndtime;
+
+	/* We were application limited (idle) for a while.
+	 * Shift epoch_start to keep cwnd growth to cubic curve.
+	 */
+	if (ca->epoch_start && delta > 0) {
+		ca->epoch_start +=3D delta;
+		if (after(ca->epoch_start, now))
+			ca->epoch_start =3D now;
+	}
+
+	ca->was_idle =3D true;
+}
+
+/* calculate the cubic root of x using a table lookup followed by one
+ * Newton-Raphson iteration.
+ * Avg err ~=3D 0.195%
+ */
+static u32 cubic_root(u64 a)
+{
+	u32 x, b, shift;
+	/* cbrt(x) MSB values for x MSB values in [0..63].
+	 * Precomputed then refined by hand - Willy Tarreau
+	 *
+	 * For x in [0..63],
+	 *   v =3D cbrt(x << 18) - 1
+	 *   cbrt(x) =3D (v[x] + 10) >> 6
+	 */
+	static const u8 v[] =3D {
+		/* 0x00 */ 0,	54,  54,  54,  118, 118, 118, 118,
+		/* 0x08 */ 123, 129, 134, 138, 143, 147, 151, 156,
+		/* 0x10 */ 157, 161, 164, 168, 170, 173, 176, 179,
+		/* 0x18 */ 181, 185, 187, 190, 192, 194, 197, 199,
+		/* 0x20 */ 200, 202, 204, 206, 209, 211, 213, 215,
+		/* 0x28 */ 217, 219, 221, 222, 224, 225, 227, 229,
+		/* 0x30 */ 231, 232, 234, 236, 237, 239, 240, 242,
+		/* 0x38 */ 244, 245, 246, 248, 250, 251, 252, 254,
+	};
+
+	b =3D fls64(a);
+	if (b < 7) {
+		/* a in [0..63] */
+		return ((u32)v[(u32)a] + 35) >> 6;
+	}
+
+	b =3D ((b * 84) >> 8) - 1;
+	shift =3D (a >> (b * 3));
+
+	x =3D ((u32)(((u32)v[shift] + 10) << b)) >> 6;
+
+	/* Newton-Raphson iteration
+	 *                         2
+	 * x    =3D ( 2 * x  +  a / x  ) / 3
+	 *  k+1          k         k
+	 */
+	x =3D (2 * x + (u32)div64_u64(a, (u64)x * (u64)(x - 1)));
+	x =3D ((x * 341) >> 10);
+	return x;
+}
+
+/* Compute congestion window to use.
+ */
+static void bictcp_update(struct roccettcp *ca, u32 cwnd,
+			  u32 acked)
+{
+	u32 delta, bic_target, max_cnt;
+	u64 offs, t;
+
+	ca->ack_cnt +=3D acked; /* count the number of ACKed packets */
+
+	if (ca->last_cwnd =3D=3D cwnd &&
+	    (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
+		return;
+
+	/* The CUBIC function can update ca->cnt at most once per jiffy.
+	 * On all cwnd reduction events, ca->epoch_start is set to 0,
+	 * which will force a recalculation of ca->cnt.
+	 */
+	if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
+		goto tcp_friendliness;
+
+	ca->last_cwnd =3D cwnd;
+	ca->last_time =3D tcp_jiffies32;
+
+	if (ca->epoch_start =3D=3D 0) {
+		ca->epoch_start =3D tcp_jiffies32; /* record beginning */
+		ca->ack_cnt =3D acked; /* start counting */
+		ca->tcp_cwnd =3D cwnd; /* syn with cubic */
+
+		if (ca->last_max_cwnd <=3D cwnd) {
+			ca->bic_K =3D 0;
+			ca->bic_origin_point =3D cwnd;
+		} else {
+			/* Compute new K based on
+			 * (wmax-cwnd) * (srtt>>3 / HZ) / c * 2^(3*bictcp_HZ)
+			 */
+			ca->bic_K =3D cubic_root(cube_factor *
+					       (ca->last_max_cwnd - cwnd));
+			ca->bic_origin_point =3D ca->last_max_cwnd;
+		}
+	}
+
+	/* In case there are any ACKs left over from LAUNCH,
+	 * apply them after the new epoch-reset
+	 */
+	if (ca->ack_carry_over) {
+		ca->ack_cnt +=3D ca->ack_carry_over;
+		ca->ack_carry_over =3D 0;
+	}
+
+	/* cubic function - calc */
+	/* calculate c * time^3 / rtt,
+	 *  while considering overflow in calculation of time^3
+	 * (so time^3 is done by using 64 bit)
+	 * and without the support of division of 64bit numbers
+	 * (so all divisions are done by using 32 bit)
+	 *  also NOTE the unit of those variables
+	 *	  time  =3D (t - K) / 2^bictcp_HZ
+	 *	  c =3D bic_scale >> 10
+	 * rtt  =3D (srtt >> 3) / HZ
+	 * !!! The following code does not have overflow problems,
+	 * if the cwnd < 1 million packets !!!
+	 */
+
+	t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
+	t +=3D usecs_to_jiffies(ca->delay_min);
+
+	/* change the unit from HZ to bictcp_HZ */
+	t <<=3D BICTCP_HZ;
+	do_div(t, HZ);
+
+	if (t < ca->bic_K) /* t - K */
+		offs =3D ca->bic_K - t;
+	else
+		offs =3D t - ca->bic_K;
+
+	/* c/rtt * (t-K)^3 */
+	delta =3D (cube_rtt_scale * offs * offs * offs) >> (10 + 3 * BICTCP_HZ);
+	if (t < ca->bic_K) /* below origin*/
+		bic_target =3D ca->bic_origin_point - delta;
+	else /* above origin*/
+		bic_target =3D ca->bic_origin_point + delta;
+
+	/* cubic function - calc bictcp_cnt*/
+	if (bic_target > cwnd)
+		ca->cnt =3D cwnd / (bic_target - cwnd);
+	else
+		ca->cnt =3D 100 * cwnd; /* very small increment*/
+
+	/* The initial growth of cubic function may be too conservative
+	 * when the available bandwidth is still unknown.
+	 */
+	if (ca->last_max_cwnd =3D=3D 0 && ca->cnt > 20)
+		ca->cnt =3D 20; /* increase cwnd 5% per RTT */
+
+tcp_friendliness:
+	/* TCP Friendly */
+	if (tcp_friendliness) {
+		u32 scale =3D beta_scale;
+
+		delta =3D (cwnd * scale) >> 3;
+		if (delta > 0) {
+			while (ca->ack_cnt > delta) { /* update tcp cwnd */
+				ca->ack_cnt -=3D delta;
+				ca->tcp_cwnd++;
+			}
+		}
+
+		if (ca->tcp_cwnd > cwnd) { /* if bic is slower than tcp */
+			delta =3D ca->tcp_cwnd - cwnd;
+			max_cnt =3D cwnd / delta;
+			if (ca->cnt > max_cnt)
+				ca->cnt =3D max_cnt;
+		}
+	}
+
+	/* The maximum rate of cwnd increase CUBIC allows is 1 packet per
+	 * 2 packets ACKed, meaning cwnd grows at 1.5x per RTT.
+	 */
+	ca->cnt =3D max(ca->cnt, 2U);
+}
+
+static void roccet_launch_update(struct sock *sk, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+
+	/* LAUNCH: Detect an exit point for tcp slow start
+	 * in networks with large buffers of multiple BDP
+	 * Like in cellular networks (5G, ...).
+	 *
+	 * Or exit LAUNCH if cwnd is too large for application layer
+	 * data rate (tcp cwnd validation).
+	 */
+	if ((ca->curr_srrtt > sr_rtt_upper_bound &&
+	     get_ack_rate_diff(ca) <=3D ack_rate_diff_ss) ||
+	    (!tcp_is_cwnd_limited(sk) && ca->initial_limit_reached)) {
+		ca->epoch_start =3D 0;
+
+		/* Handle initial LAUNCH. Most bufferbloat occurs here */
+		if (ca->is_in_initial_launch) {
+			/* Halving the cwnd will undo the previous step of slow
+			 * start. Which is fine since the pipe is already full.
+			 */
+			tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2,
+						 TCP_INIT_CWND));
+		} else {
+			tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) -
+						 (tcp_snd_cwnd(tp) / 3),
+						 TCP_INIT_CWND));
+		}
+		tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
+		ca->roccet_last_event_time_us =3D now;
+		ca->state =3D ORBITER;
+		return;
+	}
+
+	/* If not already exiting LAUNCH, grow cwnd similar to slow-start */
+	acked =3D tcp_slow_start(tp, acked);
+	/* If cwnd hits ssthresh, go to ORBITER and if any ACKs are
+	 * leftover save them for ORBITER.
+	 * Check via tcp_in_slow_start() in case no ACKs are left.
+	 */
+	if (!tcp_in_slow_start(tp)) {
+		ca->state =3D ORBITER;
+		ca->epoch_start =3D 0;
+		ca->ack_carry_over =3D acked;
+	}
+}
+
+static void roccet_orbiter_update(struct sock *sk, u32 acked)
+{
+	/* ORBITER: Increase the cwnd by using the CUBIC cwnd growth function,
+	 * if no roccet congestion event is detected.
+	 */
+
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	bool evaluate_srrtt =3D false;
+	bool sent_more_than_acked =3D false;
+	u32 roccet_xj, jitter, sent, received;
+
+	/* Enter DRAIN when roccet was recently triggered */
+	if (ca->roccet_last_event_time_us &&
+	    time_before32(now, ca->roccet_last_event_time_us +
+			  100 * USEC_PER_MSEC)) {
+		ca->state =3D DRAIN;
+		return;
+	}
+
+	/* Enter RTT_PROBE when the "timer" has expired.
+	 *
+	 * Since we are in ORBITER, we should have already received at least
+	 * one RTT sample. However safeguard against it if not.
+	 */
+	if (time_after32(now, ca->next_min_rtt_probe) &&
+	    ca->curr_rtt !=3D U32_MAX) {
+		ca->state =3D RTT_PROBE_ENTER;
+		return;
+	}
+
+	/* Calculate jitter.
+	 * Since we are in ORBITER, we should have already received at least
+	 * one RTT sample. Even if not, ca->curr_rtt and ca->curr_min_rtt
+	 * (the divisor later on) are U32_MAX, so they cancel each other out.
+	 * And if ca->last_rtt is U32_MAX, roccet_xj will be very large, so
+	 * the srRTT will not exceed it.
+	 */
+	if ((s32)(ca->curr_rtt - ca->last_rtt) < 0)
+		jitter =3D ca->last_rtt - ca->curr_rtt;
+	else
+		jitter =3D ca->curr_rtt - ca->last_rtt;
+
+	/* Calculate if more bytes were sent than received
+	 * in the time interval.
+	 *
+	 * Handle wrap arounds by relying on unsigned subtraction.
+	 * e.g. if snd_nxt wraps to 10 and seq_start is U32_MAX - 10,
+	 * the subtraction will result in the value of 21.
+	 */
+	sent =3D tp->snd_nxt - ca->interval_snd_seq_start;
+	received =3D tp->snd_una - ca->interval_una_seq_start;
+
+	/* Check sent and received bytes from the previous interval.
+	 * Here we use a guard space of 1% of the current cwnd.
+	 * We do this to avoid a false positive evaluation due
+	 * to delays caused by jitter or scheduling.
+	 */
+	sent_more_than_acked =3D
+		sent >
+		received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100);
+
+	/* Check if it's time to evaluate the srRTT */
+	if (time_after32(now, ca->next_srrtt_check_ts)) {
+		evaluate_srrtt =3D true;
+
+		/* reset struct and set next end of period */
+		ca->next_srrtt_check_ts =3D now + 5 * ca->curr_rtt;
+
+		/* Reset Rate calculation */
+		ca->interval_snd_seq_start =3D tp->snd_nxt;
+		ca->interval_una_seq_start =3D tp->snd_una;
+	}
+
+	/* Respects the jitter of the connection and add it on top of
+	 * the upper bound for the srRTT.
+	 */
+	roccet_xj =3D div_u64((u64)jitter * 100, ca->curr_min_rtt) +
+			sr_rtt_upper_bound;
+
+	/* The srRTT exceeds the upper bound if bufferbloat happens.
+	 * Here, we want to reduce the cwnd and drain the buffer.
+	 */
+	if (ca->curr_srrtt > roccet_xj && evaluate_srrtt &&
+	    sent_more_than_acked) {
+		roccet_congestion_event(sk, now);
+		return;
+	}
+
+	/* Terminates this function if cwnd is not fully utilized.
+	 * In mobile networks like 5G, this termination causes the
+	 * cwnd to be frozen at an excessively high value. This is
+	 * because slow start or HyStart massively exceed the available
+	 * bandwidth and leave the cwnd at an excessively high value.
+	 * The cwnd cannot therefore be fully utilized because it is
+	 * limited by the connection capacity.
+	 */
+	if (!tcp_is_cwnd_limited(sk) || sent_more_than_acked)
+		return;
+
+	bictcp_update(ca, tcp_snd_cwnd(tp), acked);
+	tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
+}
+
+/* The Cubic ssthresh calculation is also used for ROCCET.
+ * Called before TCP-CC state changes to TCP_CA_Recovery, TCP_CA_CWR or
+ * TCP_CA_Loss. cwnd reduction is then handled in the roccet_state() call=
back.
+ */
+static u32 roccet_recalc_ssthresh(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 cwnd =3D tcp_snd_cwnd(tp);
+
+	/* In LAUNCH, we want no reduction on loss/ECN.
+	 * On ECN this is set later on in roccet_state()
+	 */
+	if (ca->state =3D=3D LAUNCH)
+		return cwnd;
+
+	/* In min RTT probe, use the cwnd before the probe to not undershoot */
+	if (ca->state =3D=3D RTT_PROBE)
+		cwnd =3D ca->cwnd_before_min_rtt_probe;
+
+	ca->epoch_start =3D 0;	/* end of epoch */
+
+	/* Wmax and fast convergence */
+	if (cwnd < ca->last_max_cwnd && fast_convergence)
+		ca->last_max_cwnd =3D (cwnd * (BICTCP_BETA_SCALE + beta))
+			/ (2 * BICTCP_BETA_SCALE);
+	else
+		ca->last_max_cwnd =3D cwnd;
+
+	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+/* Handle a recovery event and return the new cwnd.
+ */
+static u32 roccet_handle_recovery(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 cwnd =3D tcp_snd_cwnd(tp);
+
+	/* If a loss occurs in the refill phase of min RTT probing
+	 * we reduce the cwnd and abort the refill.
+	 */
+	if (ca->state =3D=3D RTT_PROBE_REFILL)
+		ca->state =3D ORBITER;
+
+	/* In RTT_PROBE we don`t want to change state or immediately reduce
+	 * the cwnd.
+	 */
+	if (ca->state =3D=3D RTT_PROBE) {
+		roccet_min_rtt_probe_ce(ca, cwnd);
+		return tcp_snd_cwnd(tp);
+	}
+
+	/* On loss in LAUNCH, enter ORBITER without a cwnd reduction. */
+	if (ca->state =3D=3D LAUNCH) {
+		ca->state =3D ORBITER;
+		return cwnd;
+	}
+
+	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+/* Checks for state roccet-transitions and performs necessary state (re)s=
ets.
+ * This is done in order to avoid the possibility of forgetting to correc=
tly
+ * set a state when entering certain states.
+ *
+ * This is used whenever a state change is possible
+ * (e.g. in roccet_state() or roccet_control()).
+ */
+static void roccet_handle_state_transitions(struct roccettcp *ca,
+					    enum roccet_state prev_state,
+					    u32 now)
+{
+	if (ca->state =3D=3D prev_state)
+		return;
+
+	/* When we exit LAUNCH we can be sure that we are no longer in the
+	 * initial_launch. Even on LAUNCH to LAUNCH transitions (on RTO).
+	 */
+	if (prev_state =3D=3D LAUNCH)
+		ca->is_in_initial_launch =3D false;
+
+	/* Whenever we enter ORBITER, we need to schedule the next SRTT check.
+	 * This will be set before evaluating the next_srrtt_check_ts condition
+	 * as this is only done in ORBITER.
+	 */
+	if (ca->state =3D=3D ORBITER)
+		ca->next_srrtt_check_ts =3D now + 5 * ca->curr_rtt;
+
+	/* Whenever we leave the min RTT probing states (and not just
+	 * transition between them), we want to reset the probing timers.
+	 */
+	if ((prev_state =3D=3D RTT_PROBE_ENTER || prev_state =3D=3D RTT_PROBE ||
+	     prev_state =3D=3D RTT_PROBE_REFILL) &&
+	    (ca->state !=3D RTT_PROBE && ca->state !=3D RTT_PROBE_REFILL)) {
+		ca->probe_min_rtt_until =3D 0;
+		ca->refill_until =3D 0;
+	}
+}
+
+/* Handle different loss-states and perform adequate cwnd reductions.
+ */
+static void roccet_state(struct sock *sk, u8 new_state)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	u32 cwnd;
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	enum roccet_state prev_state =3D ca->state;
+
+	if (new_state =3D=3D TCP_CA_Loss) {
+		roccet_reset(sk, ca);
+		tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
+	} else if (new_state =3D=3D TCP_CA_CWR) {
+		/* Handle CWR as ROCCET congestion event,
+		 * however afterwards always set Wmax to the current cwnd.
+		 */
+		cwnd =3D tcp_snd_cwnd(tp);
+		roccet_congestion_event(sk, now);
+		ca->last_max_cwnd =3D cwnd;
+	} else if (new_state =3D=3D TCP_CA_Recovery) {
+		/* Directly reduce cwnd and rely on pacing */
+		cwnd =3D roccet_handle_recovery(sk);
+		tcp_snd_cwnd_set(tp, cwnd);
+	}
+
+	roccet_handle_state_transitions(ca, prev_state, now);
+}
+
+/* Update RTT samples and min RTT.
+ */
+static void roccet_acked(struct sock *sk, const struct ack_sample *sample=
)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 delay;
+
+	/* Some calls are for duplicates without timestamps */
+	if (sample->rtt_us < 0)
+		return;
+
+	/* Discard delay samples right after fast recovery */
+	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
+		return;
+
+	delay =3D sample->rtt_us;
+
+	if (delay =3D=3D 0)
+		delay =3D 1;
+
+	/* first call or link delay decreases */
+	if (ca->delay_min =3D=3D 0 || (s32)(delay - ca->delay_min) < 0)
+		ca->delay_min =3D delay;
+
+	/* Get valid sample for roccet */
+	if (sample->rtt_us > 0) {
+		ca->last_rtt =3D ca->curr_rtt;
+		ca->curr_rtt =3D sample->rtt_us;
+	}
+}
+
+/* Custom Pacing Rate for ROCCET TCP.
+ * The code here is similar to the pacing rate adjustments in tcp_input.c
+ * tcp_cong_control(). In LAUNCH (slow start) we want a pacing of 200% an=
d
+ * in ORBITER (congestion avoidance) we adjust the pacing to 100% and do =
not
+ * use the sysctl_tcp_pacing_ca_ratio.
+ */
+static void roccet_update_pacing_rate(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	u64 rate;
+
+	/* set sk_pacing_rate to 200 % of current rate (mss * cwnd / srtt) */
+	rate =3D (u64)tp->mss_cache * ((USEC_PER_SEC / 100) << 3);
+
+	/* current rate is (cwnd * mss) / srtt
+	 * In slow-start [1], set sk_pacing_rate to 200% the current rate.
+	 * Otherwise, set it to 100% the current rate.
+	 *
+	 * [1]: Normal Slow Start cond is (tp->snd_cwnd < tp->snd_ssthresh)
+	 *	 If snd_cwnd >=3D (tp->snd_ssthresh / 2), we are approaching
+	 *	 end of slow start and should slow down.
+	 */
+	if (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2)
+		rate *=3D READ_ONCE
+			(sock_net(sk)->ipv4.sysctl_tcp_pacing_ss_ratio);
+	else
+		/* Pacing rate of 100%
+		 * (instead of ipv4.sysctl_tcp_pacing_ca_ratio)
+		 */
+		rate *=3D 100;
+
+	rate *=3D max(tcp_snd_cwnd(tp), tp->packets_out);
+
+	if (likely(tp->srtt_us))
+		do_div(rate, tp->srtt_us);
+
+	/* WRITE_ONCE() is needed because sch_fq fetches sk_pacing_rate
+	 * without any lock. We want to make sure compiler won't store
+	 * intermediate values in this location.
+	 */
+	WRITE_ONCE(sk->sk_pacing_rate,
+		   min_t(u64, rate, READ_ONCE(sk->sk_max_pacing_rate)));
+}
+
+static void roccet_drain_update(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	if (ca->roccet_last_event_time_us &&
+	    time_after32(now, ca->roccet_last_event_time_us +
+			 100 * USEC_PER_MSEC)) {
+		if (tcp_in_slow_start(tp))
+			ca->state =3D LAUNCH;
+		else
+			ca->state =3D ORBITER;
+	}
+}
+
+static void roccet_control(struct sock *sk, u32 ack, int flag,
+			   const struct rate_sample *rs)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	enum roccet_state prev_state =3D ca->state;
+
+	/* Update ack rate. Even on no new acks/sacks. */
+	update_ack_rate(ca, rs->acked_sacked, now);
+	/* Only update RTT metrics if we have new acks/sacks in order to keep
+	 * EWMA from running multiple times for no new acks.
+	 */
+	if (rs->acked_sacked > 0) {
+		update_min_rtt(ca);
+		update_srrtt(ca);
+	}
+
+	/* Evaluate roccet state */
+	switch (ca->state) {
+	case LAUNCH:
+		roccet_launch_update(sk, rs->acked_sacked);
+		break;
+	case ORBITER:
+		roccet_orbiter_update(sk, rs->acked_sacked);
+		break;
+	case DRAIN:
+		/* In DRAIN the cwnd should not be increased */
+		roccet_drain_update(sk, now);
+		break;
+	case RTT_PROBE_ENTER:
+		roccet_enter_min_rtt_probe(sk, now);
+		break;
+	case RTT_PROBE:
+		roccet_min_rtt_probe(sk, now);
+		break;
+	case RTT_PROBE_REFILL:
+		roccet_rtt_probe_refill(ca, now);
+		break;
+	default:
+		pr_err_once("TCP ROCCET: Invalid state %d", ca->state);
+	}
+
+	roccet_handle_state_transitions(ca, prev_state, now);
+
+	roccet_update_pacing_rate(sk);
+
+	if (tcp_is_cwnd_limited(sk))
+		ca->initial_limit_reached =3D true;
+}
+
+static struct tcp_congestion_ops roccet_tcp __read_mostly =3D {
+	.init =3D roccet_init,
+	.ssthresh =3D roccet_recalc_ssthresh,
+	.set_state =3D roccet_state,
+	.undo_cwnd =3D tcp_reno_undo_cwnd,
+	.cwnd_event_tx_start =3D roccet_cwnd_event_tx_start,
+	.pkts_acked =3D roccet_acked,
+	.cong_control =3D roccet_control,
+	.owner =3D THIS_MODULE,
+	.name =3D "roccet",
+};
+
+static int __init roccet_register(void)
+{
+	int param_err;
+
+	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
+
+	/* Check for valid parameter ranges and then precompute factors */
+	param_err =3D param_check();
+
+	if (param_err)
+		return param_err;
+
+	param_precompute();
+
+	return tcp_register_congestion_control(&roccet_tcp);
+}
+
+static void __exit roccet_unregister(void)
+{
+	tcp_unregister_congestion_control(&roccet_tcp);
+}
+
+module_init(roccet_register);
+module_exit(roccet_unregister);
+
+MODULE_AUTHOR("Lukas Prause, Tim F=C3=BCchsel");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ROCCET TCP");

base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
=2D-=20
2.43.0

